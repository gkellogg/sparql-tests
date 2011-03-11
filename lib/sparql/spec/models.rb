require 'rdf'
require 'spira'
require 'rdf/n3'
require 'rdf/isomorphic'

module SPARQL::Spec
  DAWG = RDF::Vocabulary.new('http://www.w3.org/2001/sw/DataAccess/tests/test-dawg#')
  MF = RDF::Vocabulary.new('http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#')
  QT = RDF::Vocabulary.new('http://www.w3.org/2001/sw/DataAccess/tests/test-query#')
  RS = RDF::Vocabulary.new('http://www.w3.org/2001/sw/DataAccess/tests/result-set#')

  class Manifest < Spira::Base
    type MF.Manifest
    has_many :manifests,  :predicate => MF.include
    property :entry_list, :predicate => MF.entries
    property :comment,    :predicate => RDFS.comment

    def entries
      RDF::List.new(entry_list, self.class.repository).map { |entry| entry.as(SPARQLTest) }
    end

    def include_files!
      manifests.each do |manifest|
        RDF::List.new(manifest, self.class.repository).each do |file|
          case file.path
          when /(clear|drop|basic-update|delete)/ 
            next
          else
            puts "Loading #{file.path}"
            self.class.repository.load(file.path, :context => file.path)
          end
        end
      end
    end
  end

  class SPARQLTest < Spira::Base
    property :name, :predicate => MF.name
    property :type, :predicate => RDF.type
    property :comment, :predicate => RDFS.comment
    property :_action, :predicate => MF.action, :type => 'SPARQLAction'
    property :result, :predicate => MF.result
    property :approval, :predicate => DAWG.approval
    property :approved_by, :predicate => DAWG.approvedBy
    property :manifest, :predicate => MF.manifest_file

    has_many :tags, :predicate => MF.tag

    # Support for simplified YAML representation
    def for_yaml
      SPARQLTestYAML.new(
        subject.to_s,
        name,
        (type ? type.to_s : nil),
        comment,
        (action.query_file ? action.query_file.to_s : nil),
        (action.test_data ? action.test_data.to_s : nil),
        action.graphData.to_a.map(&:to_s),
        (result ? result.to_s : nil),
        (approval ? approval.to_s : nil),
        (approved_by ? approved_by.to_s : nil),
        (manifest ? manifest.to_s : nil),
        tags)
    end
    
    # For Syntax tests, mf:action is a simple URI, otherwise, is a SPARQLAction
    def action
      @action ||= if _action.query_file
        _action
      else
        SPARQLAction.new {|a| a.query_file = _action.subject; a.graphData = []; }
      end
    end
    
    def action=(act)
      @action = act
    end
    
    def inspect
      "[#{self.class.to_s} " + %w(
        subject
        name
        type
        result
        approved?
      ).map {|a| v = self.send(a); "#{a}='#{v}'" if v}.compact.join(", ") +
      ", query_file=#{action.query_file}" + 
      (action.test_data ? ", test_data=#{action.test_data}" : "") + 
      "]"
    end

    def approved?
      approval == DAWG.Approved
    end

    def form
      query_data = begin IO.read(action.query_file.path) rescue nil end
      if query_data =~ /(ASK|CONSTRUCT|DESCRIBE|SELECT)/i
        case $1.upcase
          when 'ASK'
            :ask
          when 'SELECT'
            :select
          when 'DESCRIBE'
            :describe
          when 'CONSTRUCT'
            :construct
        end
      else
        raise "Couldn't determine query type for #{File.basename(subject)} (reading #{action.query_file})"
      end
    end
  end

  SPARQLTestYAML = Struct.new(:subject, :name, :type, :comment, :query_file, :test_data, :graph_data, :result, :approval, :approved_by, :manifest, :tags) do
    def to_test
      SPARQLTest.new do |test|
        #test.subject = RDF::URI(subject)
        test.name = name
        test.type = RDF::URI(type) if type
        test.comment = comment
        test.action = SPARQLAction.new do |a|
          a.query_file = RDF::URI(query_file)
          a.test_data = RDF::URI(test_data) if test_data
          a.graphData = graph_data.map {|u| RDF::URI(u)}
        end
        test.result = RDF::URI(result) if approval
        test.approval = RDF::URI(approval) if approval
        test.approved_by = RDF::URI(approved_by) if approved_by
        test.manifest = RDF::URI(manifest) if manifest
        test.tags = tags
      end
    end
  end

  class SPARQLAction < Spira::Base
    property :query_file, :predicate => QT.query
    property :test_data,  :predicate => QT.data
    has_many :graphData, :predicate => QT.graphData

    def query_string
      IO.read(query_file.path)
    end

    def sse_file
      RDF::URI(query_file.to_s.sub(/.rq$/, ".sse"))
    end
  
    def sse_string
      IO.read(sse_file.path)
    end
  end

  class SPARQLBinding < Spira::Base
    property :value,    :predicate => RS.value, :type => Native
    property :variable, :predicate => RS.variable
    default_source :results
  end

  class BindingSet < Spira::Base
    default_source :results
    has_many :bindings, :predicate => RS.binding, :type => 'SPARQLBinding'
    property :index,    :predicate => RS.index, :type => Integer
  end

  class ResultBindings < Spira::Base
    type RS.ResultSet
    has_many :variables, :predicate => RS.resultVariable
    has_many :solution_lists, :predicate => RS.solution, :type => 'BindingSet'
    property :boolean, :predicate => RS.boolean, :type => Boolean # for ask queries
    default_source :results

    def solutions
      @solutions ||= solution_lists.map { |solution_list|
        solution_list.bindings.inject({}) { |hash, binding|
          hash[binding.variable.to_sym] = binding.value
          hash
        }
      }
    end

    def self.for_solutions(solutions, opts = {})
      opts[:uri] ||= RDF::Node.new
      index = 1 if opts[:index]
      result_bindings = self.for(opts[:uri]) do | binding_graph |
        solutions.each do | result_hash | 
          binding_graph.solution_lists << BindingSet.new do | binding_set |
            result_hash.to_hash.each_pair do |hash_variable, hash_value|
              binding_set.bindings << SPARQLBinding.new do | sparql_binding |
                sparql_binding.variable = hash_variable.to_s
                sparql_binding.value = hash_value.respond_to?(:canonicalize) ? hash_value.dup.canonicalize : hash_value
              end
            end
            if opts[:index]
              binding_set.index = index
              index += 1
            end
          end
        end
      end
    end

    def self.pretty_print
      self.each do |result_binding|
      log "Result Bindings #{result_binding.subject}"
        result_binding.solution_lists.each.sort { |bs, other| bs.index.respond_to?(:'<=>') ? bs.index <=>  other.index : 0 }.each do |binding_set|
           log "  Solution #{binding_set.subject} (# #{binding_set.index})"
           binding_set.bindings.sort { |b, other| b.variable.to_s <=> other.variable.to_s }.each do |binding|
             log "    #{binding.variable}: #{binding.value.inspect}"
           end
        end
      end
    end

  end
end
