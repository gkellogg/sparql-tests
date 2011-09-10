require 'rdf'
require 'spira'
require 'rdf/n3'
require 'rdf/rdfxml'
require 'sparql/client'

module SPARQL::Spec
  DAWG = RDF::Vocabulary.new('http://www.w3.org/2001/sw/DataAccess/tests/test-dawg#')
  MF = RDF::Vocabulary.new('http://www.w3.org/2001/sw/DataAccess/tests/test-manifest#')
  UT = RDF::Vocabulary.new('http://www.w3.org/2009/sparql/tests/test-update#')
  QT = RDF::Vocabulary.new('http://www.w3.org/2001/sw/DataAccess/tests/test-query#')
  RS = RDF::Vocabulary.new('http://www.w3.org/2001/sw/DataAccess/tests/result-set#')

  class Manifest < Spira::Base
    type MF.Manifest
    has_many :manifests,  :predicate => MF.include
    property :entry_list, :predicate => MF.entries
    property :comment,    :predicate => RDFS.comment

    def entries
      RDF::List.new(entry_list, self.class.repository).map do |entry|
        type = self.class.repository.query(:subject => entry, :predicate => RDF.type).first.object
        case type
          when UT.UpdateEvaluationTest, MF.UpdateEvaluationTest
            entry.as(UpdateTest)
          when MF.QueryEvaluationTest
            entry.as(QueryTest)
          # known types to ignore
          when MF.PositiveSyntaxTest, MF.NegativeSyntaxTest, MF.NegativeSyntaxTest11
            entry.as(SyntaxTest)
          else
            warn "Unknown test type for #{entry}: #{type}"
        end
      end.compact
    end

    def include_files!
      manifests.each do |manifest|
        RDF::List.new(manifest, self.class.repository).each do |file|
          puts "Loading #{file}"
          self.class.repository.load(File.join(BASE_DIRECTORY, file.path), :context => file, :base_uri => file.path)
        end
      end
    end
  end

  class Spira::Base
    def encode_with(coder)
      coder["subject"] = subject
      attributes.each {|p,v| coder[p.to_s] = v if v}
    end

    def init_with(coder)
      self.instance_variable_set(:"@subject", coder["subject"])
      self.reload
      attributes.each {|p,v| self.attribute_set(p, coder.map[p.to_s])}
    end
  end
  
  class SPARQLTest < Spira::Base
    property :name, :predicate => MF.name
    property :type, :predicate => RDF.type
    property :comment, :predicate => RDFS.comment
    property :approval, :predicate => DAWG.approval
    property :approved_by, :predicate => DAWG.approvedBy
    property :manifest, :predicate => MF.manifest_file
    has_many :tags, :predicate => MF.tag

    def inspect
      "[#{super} " + attributes.keys.map do |a|
        v = attributes[a]; "#{a}=#{v.inspect}" if v
      end.compact.join(", ") +
      "]"
    end

    def approved?
      approval == DAWG.Approved
    end

    def form
      query_data = begin action.query_string rescue nil end
      if query_data =~ /(ASK|CONSTRUCT|DESCRIBE|SELECT|DELETE|LOAD|INSERT|CREATE|CLEAR|DROP)/i
        case $1.upcase
          when 'ASK', 'SELECT', 'DESCRIBE', 'CONSTRUCT'
            $1.downcase.to_sym
          when 'DELETE', 'LOAD', 'INSERT', 'CREATE', 'CLEAR', 'DROP'
            :update
        end
      else
        raise "Couldn't determine query type for #{File.basename(subject)} (reading #{action.query_file})"
      end
    end
  end

  class UpdateTest < SPARQLTest
    property :result, :predicate => MF.result, :type => 'UpdateResult'
    property :action, :predicate => MF.action, :type => 'UpdateAction'

    def query_file
      action.request
    end

    def template_file
      'update-test.rb.erb'
    end

    def query
      IO.read("#{BASE_DIRECTORY}/#{query_file.path}")
    end
  end

  class UpdateDataSet < Spira::Base
    has_many :graphData, :predicate => UT.graphData, :type => 'UpdateGraphData'
    property :data_file, :predicate => UT.data

    def data
      IO.read("#{BASE_DIRECTORY}/#{data_file.path}")
    end

    def data_format
      File.extname(data_file).sub(/\./,'').to_sym
    end
  end

  class UpdateAction < UpdateDataSet
    property :request, :predicate => UT.request

    def query_file
      request
    end
  end

  class UpdateResult < UpdateDataSet
  end

  class UpdateGraphData < Spira::Base
    property :graph, :predicate => UT.graph
    property :basename, :predicate => RDFS.label, :type => Spira::Types::URI

    def data_file
      graph
    end

    def data
      IO.read(graph)
    end

    def data_format
      File.extname(data_file).sub(/\./,'').to_sym
    end
  end

  class QueryTest < SPARQLTest
    property :action, :predicate => MF.action, :type => 'QueryAction'
    property :result, :predicate => MF.result

    def query_file
      action.query_file
    end

    def template_file
      'query-test.rb.erb'
    end

    # Load and return default and named graphs in a hash
    def graphs
      @graphs ||= begin
        graphs = {}
        graphs[:default] = {:data => action.test_data_string, :format => :ttl} if action.test_data
        action.graphData.each do |g|
          graphs[g] = {:data => IO.read("#{BASE_DIRECTORY}/#{g.path}"), :format => :ttl}
        end
        graphs
      end
    end

    # Turn results into solutions
    def solutions
      return nil if respond_to?(:result) || result.nil?

      case form
      when :select
        if File.extname(result.path) == '.srx'
          SPARQL::Client.parse_xml_bindings(File.read("#{BASE_DIRECTORY}/#{result.path}"))
        else
          expected_repository = RDF::Repository.new 
          Spira.add_repository!(:results, expected_repository)
          expected_repository.load("#{BASE_DIRECTORY}/#{result.path}")
          SPARQL::Spec::ResultBindings.each.first.solutions
        end
      when :ask
        return true
      when :describe, :create
        RDF::Graph.load("#{BASE_DIRECTORY}/#{result.path}", :format => :ttl)
      end
    end

  end

  class UpdateTest < SPARQLTest
    property :result, :predicate => MF.result, :type => 'UpdateResult'
    property :action, :predicate => MF.action, :type => 'UpdateAction'

    def query_file
      action.request
    end

    def template_file
      'update-test.rb.erb'
    end

    def query
      IO.read(query_file)
    end
  end

  class SyntaxTest < SPARQLTest
    property :_action, :predicate => MF.action

    # Construct an action instance, as this form only uses a simple URI
    def action
      @action ||= QueryAction.new {|a| a.query_file = _action; a.graphData = []; }
    end
  end

  class QueryAction < Spira::Base
    property :query_file, :predicate => QT.query
    property :test_data,  :predicate => QT.data
    has_many :graphData,  :predicate => QT.graphData

    def query_string
      IO.read("#{BASE_DIRECTORY}/#{query_file.path}")
    end

    def sse_file
      RDF::URI(query_file.to_s.sub(/.rq$/, ".sse"))
    end
  
    def sse_string
      IO.read("#{BASE_DIRECTORY}/#{sse_file.path}")
    end

    def test_data_string
      IO.read("#{BASE_DIRECTORY}/#{test_data.path}")
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
    has_many :variables, :predicate => RS.ResultSet
    has_many :solution_lists, :predicate => RS.solution, :type => 'BindingSet'
    property :boolean, :predicate => RS.boolean, :type => Boolean # for ask queries
    default_source :results

    # Return bindings as an list of Solutions
    # @return [Enumerable<RDF::Query::Solution>]
    def solutions
      @solutions ||= begin
        solution_lists.
          sort_by {|solution_list| solution_list.index.to_i}.
          map do |solution_list|
          bindings = solution_list.bindings.inject({}) { |hash, binding|
            hash[binding.variable.to_sym] = binding.value
            hash
          }
          RDF::Query::Solution.new(bindings)
        end
      end
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

# Save short version of URI, without all the Addressable stuff.
class RDF::URI
  def encode_with(coder)
    coder["uri"] = self.to_s
  end
  
  def init_with(coder)
    @uri = Addressable::URI.parse(coder["uri"])
  end
end
