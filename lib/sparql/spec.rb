require 'rdf'   # @see http://rubygems.org/gems/rdf
require 'rdf/ntriples'
require 'rdf/n3'
require 'rspec' # @see http://rubygems.org/gems/rspec

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
    autoload :Manifest,       'sparql/spec/models'
    autoload :SPARQLTest,     'sparql/spec/models'
    autoload :SPARQLAction,   'sparql/spec/models'
    autoload :SPARQLBinding,  'sparql/spec/models'
    autoload :BindingSet,     'sparql/spec/models'
    autoload :ResultBindings, 'sparql/spec/models'

    # Module functions
    
    ##
    # Load tests from the specified file/uri.
    # @param [String] manifest_uri
    # @param [Hash<Symbol => Object>] options
    # @option options [String] :base_uri (manifest_uri)
    # @option options [String] :context (nil)
    # @option options [String] :context (nil)
    # @option options [String] :include_files (nil)
    #   Load included manifests
    # @return [Array<SPARQL::Spec::SPARQLTest>]
    def self.load_tests(manifest_uri, options = {})
      options[:base_uri] ||= manifest_uri

      require 'spira'

      puts "Loading tests from #{manifest_uri}"
      test_repo = RDF::Repository.new
      Spira.add_repository(:default, test_repo)
      test_repo.load(manifest_uri, options)
      if options[:include_files]
        Manifest.each { |manifest| manifest.include_files! }
        tests = Manifest.each.map { |m| m.entries }.flatten.find_all { |t| t.approved? }
        tests.each { |test|
          test.tags << 'status:unverified'
          test.tags << 'w3c_status:unapproved' unless test.approved?
          test.update!(:manifest => test.data.each_context.first)
        }
      else
        tests = Manifest.each.map { |m| m.entries }.flatten.find_all { |t| t.approved? }
        tests.each { |test| test.update!(:manifest => manifest_file) unless test.manifest }
      end
    end

    def self.load_sparql1_0_tests(cache = true)
      base_directory = File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', 'tests')
      cache_file = './sparql-specs-1_0-cache.nt'
      if ENV['MANIFEST']
        self.load_tests(ENV['MANIFEST'], :context => ENV['MANIFEST'])
      elsif File.exists?(cache_file)
        self.load_tests(cache_file)
      else
        tests = self.load_tests("#{base_directory}/data-r2/manifest-evaluation.ttl", :include_files => true)
        if cache
          File.open(cache_file, 'w+') do |file|
            file.write RDF::Writer.for(:ntriples).dump(Spira.repository(:default))
          end
        end
        tests
      end
    end

    def self.load_sparql1_0_syntax_tests(cache = true)
      base_directory = File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', 'tests')
      cache_file = './sparql-specs-1_0_syntax-cache.nt'
      if ENV['MANIFEST']
        self.load_tests(ENV['MANIFEST'], :context => ENV['MANIFEST'])
      elsif File.exists?(cache_file)
        self.load_tests(cache_file)
      else
        tests = self.load_tests("#{base_directory}/data-r2/manifest-syntax.ttl", :include_files => true)
        if cache
          File.open(cache_file, 'w+') do |file|
            file.write RDF::Writer.for(:ntriples).dump(Spira.repository(:default))
          end
        end
        tests
      end
    end

    def self.load_sparql1_1_tests(cache = true)
      base_directory = File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', 'tests')
      cache_file = './sparql-specs-cache.nt'
      if ENV['MANIFEST']
        self.load_tests(ENV['MANIFEST'], :context => ENV['MANIFEST'])
      elsif File.exists?(cache_file)
        self.load_tests(cache_file)
      else
        tests = self.load_tests("#{base_directory}/sparql11-tests/data-sparql11/manifest-all.ttl", :include_files => true)
        if cache
          File.open(cache_file, 'w+') do |file|
            file.write RDF::Writer.for(:ntriples).dump(Spira.repository(:default))
          end
        end
        tests
      end
    end
  end # Spec
end # RDF
