# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Function sort
# Sort by function invocation
# /Users/ben/repos/datagraph/tests/tests/data-r2/sort/query-sort-function.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-sort-function
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0096/21-dawg-minutes.html
#
describe "W3C test" do
  context "sort" do
    before :all do
      @data = %q{
@prefix : <http://example.org/> .

:s1 :p "2" .
:s2 :p "300" .
:s3 :p "10" .


}
      @query = %q{
PREFIX : <http://example.org/>
PREFIX xsd: <http://www.w3.org/2001/XMLSchema#>
SELECT ?s WHERE {
  ?s :p ?o .
} ORDER BY xsd:integer(?o)

}
    end

    example "Function sort" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'sort-dawg-sort-function'
      results = [
          { 
              :s => RDF::URI('http://example.org/s1'),
          },
          { 
              :s => RDF::URI('http://example.org/s2'),
          },
          { 
              :s => RDF::URI('http://example.org/s3'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ results
    end
  end
end
