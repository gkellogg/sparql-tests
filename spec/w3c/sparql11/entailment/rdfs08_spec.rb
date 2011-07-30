# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# RDFS inference test rdf:XMLLiteral subclass of rdfs:Literal
# 
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/entailment/rdfs08.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#rdfs08
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "entailment" do
    before :all do
      @data = %q{
@prefix ex: <http://example.org/ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

ex:d rdfs:range rdf:XMLLiteral .


}
      @query = %q{
PREFIX ex: <http://example.org/ns#>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
SELECT ?x
WHERE {
  ex:d rdfs:range ?x .
}


}
    end

    example "RDFS inference test rdf:XMLLiteral subclass of rdfs:Literal", :status => 'bug', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'entailment-rdfs08'
      expected = [
          { 
              :x => RDF::URI('http://www.w3.org/1999/02/22-rdf-syntax-ns#XMLLiteral'),
          },
          { 
              :x => RDF::URI('http://www.w3.org/2000/01/rdf-schema#Literal'),
          },
          { 
              :x => RDF::URI('http://www.w3.org/2000/01/rdf-schema#Resource'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
