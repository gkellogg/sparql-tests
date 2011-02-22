# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# ASK-8 (SPARQL XML results)
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/ask/ask-8.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#ask-8
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0087/14-dawg-minutes.html
#
describe "W3C test" do
  context "ask" do
    before :all do
      @data = %q{
@prefix :   <http://example/> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:x :p "1"^^xsd:integer .
:x :p "2"^^xsd:integer .
:x :p "3"^^xsd:integer .

:y :p :a .
:a :q :r .

}
      @query = %q{
(ask
     (filter (= ?x 99)
             (bgp (triple <http://example/x> <http://example/p> ?x))))

}
    end

    example "ASK-8 (SPARQL XML results)" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'ask-ask-8'
      expected = false

      sparql_query(:graphs => graphs, :query => @query,
                   :repository => repository, :form => :ask).should == expected
    end
  end
end
