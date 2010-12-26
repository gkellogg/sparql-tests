# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Builtin sort
# Sort by a builtin operator
# /Users/ben/repos/datagraph/tests/tests/data-r2/sort/query-sort-builtin.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-sort-builtin
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

:s1 :p "2"^^xsd:integer .
:s2 :p "300"^^xsd:integer .
:s3 :p "10"^^xsd:integer .


}
      @query = %q{
PREFIX : <http://example.org/>
SELECT ?s WHERE {
  ?s :p ?o .
} ORDER BY str(?o)

}
    end

    example "Builtin sort" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'sort-dawg-sort-builtin'
      expected = [
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


      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :select).should == expected
    end
  end
end
