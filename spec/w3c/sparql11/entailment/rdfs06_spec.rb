# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# RDFS inference test domain
# 
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/entailment/rdfs06.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#rdfs06
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

ex:a ex:b ex:c .
ex:b rdfs:domain ex:aType .


}
      @query = %q{
PREFIX ex: <http://example.org/ns#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
SELECT ?x
WHERE {
  ?x rdf:type ex:aType .
}


}
    end

    example "RDFS inference test domain", :status => 'bug', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'entailment-rdfs06'
      expected = [
          { 
              :x => RDF::URI('http://example.org/ns#a'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
