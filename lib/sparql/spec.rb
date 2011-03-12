require 'rdf'   # @see http://rubygems.org/gems/rdf
require 'rdf/ntriples'
require 'rdf/n3'
require 'rspec' # @see http://rubygems.org/gems/rspec
require 'yaml'
require 'sparql/spec/inspects'
require 'sparql/spec/isomorphic'
require 'sparql/spec/matchers'

module SPARQL
  ##
  # **`SPARQL::Spec`** provides RSpec extensions for SPARQL.
  #
  # @example Requiring the `SPARQL::Spec` module
  #   require 'sparql/spec'
  #
  # @example Using the shared examples for `SPARQL::Spec::SSE`
  #   require 'sparql/spec/sse'
  #   
  #   describe SPARQL::Enumerable do
  #     before :each do
  #       @statements = RDF::NTriples::Reader.new(File.open("etc/doap.nt")).to_a
  #       @enumerable = @statements.dup.extend(RDF::Enumerable)
  #     end
  #     
  #     it_should_behave_like RDF_Enumerable
  #   end
  #
  # @example Using the shared examples for `RDF::Repository`
  #   require 'rdf/spec/repository'
  #   
  #   describe RDF::Repository do
  #     before :each do
  #       @repository = RDF::Repository.new
  #     end
  #     
  #     it_should_behave_like RDF_Repository
  #   end
  #
  # @see http://rdf.rubyforge.org/
  # @see http://rspec.info/
  #
  # @author [Arto Bendiken](http://ar.to/)
  # @author [Ben Lavender](http://bhuga.net/)
  module Spec
    autoload :Manifest,         'sparql/spec/models'
    autoload :SPARQLTest,       'sparql/spec/models'
    autoload :SPARQLAction,     'sparql/spec/models'
    autoload :SPARQLTestYAML,   'sparql/spec/models'
    autoload :SPARQLBinding,    'sparql/spec/models'
    autoload :BindingSet,       'sparql/spec/models'
    autoload :ResultBindings,   'sparql/spec/models'

    BASE_DIRECTORY = File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', 'tests')

    # Module functions
    
    ##
    # Load tests from the specified file/uri.
    # @param [String] manifest_uri
    # @param [Hash<Symbol => Object>] options
    # @option options [String] :cache_file (nil)
    #   Attempt to load parsed tests from YAML file
    # @option options [String] :save_cache (false)
    #   Save parsed tests in cache_file
    # @return [Array<SPARQL::Spec::SPARQLTest>]
    def self.load_tests(manifest_uri, options = {})
      require 'spira'
      options[:base_uri] ||= manifest_uri

      test_repo = RDF::Repository.new
      Spira.add_repository(:default, test_repo)

      if options[:cache_file] && File.exists?(options[:cache_file])
        
        File.open(options[:cache_file]) do |f|
          YAML.load(f).map(&:to_test)
        end
      else

        puts "Loading tests from #{manifest_uri}"
        test_repo.load(manifest_uri, options)
        Manifest.each { |manifest| manifest.include_files! }
        tests = Manifest.each.map { |m| m.entries }.flatten.find_all { |t| t.approved? }
        tests.each { |test|
          test.tags << 'status:unverified'
          test.tags << 'w3c_status:unapproved' unless test.approved?
          test.update!(:manifest => test.data.each_context.first)
        }
          
        if options[:save_cache]
          puts "write test cases to #{options[:cache_file]}"
          File.open(options[:cache_file], 'w') do |f|
            YAML.dump(tests.map(&:for_yaml), f)
          end
        end
        
        tests
      end
    end

    def self.load_sparql1_0_tests(save_cache = false)
      self.load_tests("#{BASE_DIRECTORY}/data-r2/manifest-evaluation.ttl",
        :cache_file => File.join(BASE_DIRECTORY, "sparql-specs-1_0-cache.yml"),
        :save_cache => save_cache)
    end

    def self.load_sparql1_0_syntax_tests(save_cache = false)
      self.load_tests("#{BASE_DIRECTORY}/data-r2/manifest-syntax.ttl",
        :cache_file => File.join(BASE_DIRECTORY, "sparql-specs-1_0_syntax-cache.yml"),
        :save_cache => save_cache)
    end

    def self.load_sparql1_1_tests(save_cache = false)
      self.load_tests("#{BASE_DIRECTORY}/sparql11-tests/data-sparql11/manifest-all.ttl",
        :cache_file => File.join(BASE_DIRECTORY, "sparql-specs-1_1_cache.yml"),
        :save_cache => save_cache)
    end
  end # Spec
end # RDF
