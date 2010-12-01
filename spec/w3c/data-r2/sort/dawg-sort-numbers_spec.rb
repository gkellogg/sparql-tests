# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Expression sort
# Sort by a bracketted expression
# /Users/ben/repos/datagraph/tests/tests/data-r2/sort/query-sort-numbers.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-sort-numbers
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0096/21-dawg-minutes.html
#
describe "W3C test" do
  context "sort" do
    before :all do
      @data = %q{
@prefix : <http://example.org/> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:s1 :p "1"^^xsd:integer; :q "2"^^xsd:integer .
:s2 :p "10"^^xsd:integer; :q "20"^^xsd:integer .
:s3 :p "100"^^xsd:integer; :q "200"^^xsd:integer .


}
      @query = %q{
PREFIX : <http://example.org/>
SELECT ?s WHERE {
  ?s :p ?o1 ; :q ?o2 .
} ORDER BY (?o1 + ?o2)

}
    end

    example "Expression sort" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'sort-dawg-sort-numbers'
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
