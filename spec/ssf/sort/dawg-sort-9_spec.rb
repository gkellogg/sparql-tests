# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# sort-9
# Alphabetic sort (ascending) on datatyped (string) literals
# /Users/ben/repos/datagraph/tests/tests/data-r2/sort/query-sort-9.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-sort-9
#
# This test is approved: 
# http://www.w3.org/2007/06/26-dawg-minutes
#
describe "W3C test" do
  context "sort" do
    before :all do
      @data = %q{
@prefix rdf:    <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

_:a foaf:name "Eve"^^xsd:string .
_:b foaf:name "Alice"^^xsd:string .
_:c foaf:name "Fred"^^xsd:string .
_:e foaf:name "Bob"^^xsd:string .



}
      @query = %q{
(select (?name)
  (project (?name)
    (order (?name)
      (bgp (triple ?x <http://xmlns.com/foaf/0.1/name> ?name)))))

}
    end

    example "sort-9" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'sort-dawg-sort-9'
      expected = [
          { 
              :name => RDF::Literal.new('Alice' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              :name => RDF::Literal.new('Bob' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              :name => RDF::Literal.new('Eve' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              :name => RDF::Literal.new('Fred' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :select).should == expected
    end
  end
end
