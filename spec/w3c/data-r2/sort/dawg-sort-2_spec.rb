# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# sort-2
# Alphabetic sort (descending) on untyped literals
# /Users/ben/repos/datagraph/tests/tests/data-r2/sort/query-sort-2.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-sort-2
#
#
# 
# This test is approved: http://www.w3.org/2007/06/26-dawg-minutes
#
describe "W3C test " do
  context "sort" do
    before :all do
      @data = %q{
@prefix rdf:    <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .

_:a foaf:name "Eve".
_:b foaf:name "Alice" .
_:c foaf:name "Fred" .
_:e foaf:name "Bob" .

}
      @query = %q{
(select (?name)
  (project (?name)
    (order ((desc ?name))
      (bgp (triple ?x <http://xmlns.com/foaf/0.1/name> ?name)))))

}
    end

    it "sort-2" do
    
      graphs = { :default => { :data => @data, :format => :ttl} }

      repository = 'sort-dawg-sort-2'
      results = [
          { 
              "name" => RDF::Literal.new('Fred' ),
          },
          { 
              "name" => RDF::Literal.new('Eve' ),
          },
          { 
              "name" => RDF::Literal.new('Bob' ),
          },
          { 
              "name" => RDF::Literal.new('Alice' ),
          },
      ]


      
      sparql_query(:graphs => graphs, :query => @query, 
                   :repository => repository, :form => :select)
    end
  end
end
