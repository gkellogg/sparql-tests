# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Subtraction
# A - B in FILTER expressions
# /Users/ben/repos/datagraph/tests/tests/data-r2/expr-ops/query-minus-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#minus-1
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0087/14-dawg-minutes.html
#
describe "W3C test" do
  context "expr-ops" do
    before :all do
      @data = %q{
@prefix : <http://example.org/> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:x1 :p "1"^^xsd:integer .
:x2 :p "2"^^xsd:integer .
:x3 :p "3"^^xsd:integer .
:x4 :p "4"^^xsd:integer .

}
      @query = %q{
        (prefix ((: <http://example.org/>))
          (project (?s)
            (filter (= (- ?o ?o2) 3)
              (bgp
                (triple ?s :p ?o)
                (triple ?s2 :p ?o2)
              ))))
}
    end

    example "Subtraction" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'expr-ops-minus-1'
      expected = [
          { 
              :s => RDF::URI('http://example.org/x4'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
