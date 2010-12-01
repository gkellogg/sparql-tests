# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# graph-04
# Data: named graph / Query: default graph
# /Users/ben/repos/datagraph/tests/tests/data-r2/graph/graph-04.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-graph-04
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0047/31-dawg-minutes
#
describe "W3C test" do
  context "graph" do
    before :all do
      @data = %q{
@prefix : <http://example/> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:x :p "1"^^xsd:integer .
:a :p "9"^^xsd:integer .

}
      @query = %q{
PREFIX : <http://example/> 

SELECT * { 
    GRAPH ?g { ?s ?p ?o }
}


}
    end

    example "graph-04" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'graph-dawg-graph-04'
      results = [
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ results
    end
  end
end
