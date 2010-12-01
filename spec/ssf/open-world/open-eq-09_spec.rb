# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# open-eq-09
# Test of '='
# /Users/ben/repos/datagraph/tests/tests/data-r2/open-world/open-eq-09.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#open-eq-09
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/att-0082/2007-06-12-dawg-minutes.html
#
describe "W3C test" do
  context "open-world" do
    before :all do
      @data = %q{
@prefix     : <http://example/> .
@prefix  xsd:    <http://www.w3.org/2001/XMLSchema#> .

:x1 :p "xyz" .
:x2 :p "xyz"@en .
:x3 :p "xyz"@EN .
:x4 :p "xyz"^^xsd:string .
:x5 :p "xyz"^^xsd:integer .
:x6 :p "xyz"^^:unknown .
:x7 :p _:xyz .
:x8 :p :xyz .

:y1 :q "abc" .
:y2 :q "abc"@en .
:y3 :q "abc"@EN .
:y4 :q "abc"^^xsd:string .
:y5 :q "abc"^^xsd:integer .
:y6 :q "abc"^^:unknown .
:y7 :q _:abc .
:y8 :q :abc .

}
      @query = %q{
(select (?v1 ?v2 ?x ?y)
  (filter (= ?v1 ?v2)
    (bgp
      (triple ?x <http://example/p> ?v1)
      (triple ?y <http://example/q> ?v2)
    )))

}
    end

    example "open-eq-09" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'open-world-open-eq-09'
      results = [
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ results
    end
  end
end
