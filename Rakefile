
require 'bundler'
Bundler.setup
Bundler.require(:default)
require 'rspec/core/rake_task'

namespace :spec do
  RSpec::Core::RakeTask.new('csv') do |t|
    file = File.dirname(__FILE__) + '/spec/support/formatters/csv_formatter.rb'
    t.rspec_opts = []
    t.rspec_opts  << ['--require', file]
    t.rspec_opts << ['--format', 'CSVFormatter']
    t.rspec_opts << ['--tag', '~values:lexical']
    t.rspec_opts << ['--tag', '~arithmetic:boxed']
    t.rspec_opts << ['--tag', '~blank_nodes:unique']
    t.rspec_opts << ['--tag', '~reduced:all']
    t.rspec_opts << ['--tag', '~status:bug']
    t.pattern = 'spec/w3c/data-r2/**/*.rb'
    t.verbose = false
  end

  desc "Generate test caches"
  task :prepare do
    $:.unshift(File.join(File.dirname(__FILE__), 'lib'))
    require 'sparql/spec'
    require 'fileutils'
    
    Dir.glob("./tests/*.yml") { |yml| FileUtils.rm_rf(yml)}

    puts "load 1.0 tests"
    SPARQL::Spec.load_sparql1_0_tests(true)
    puts "load 1.0 syntax tests"
    SPARQL::Spec.load_sparql1_0_syntax_tests(true)
    puts "load 1.1 tests"
    SPARQL::Spec.load_sparql1_1_tests(true)
  end
end
