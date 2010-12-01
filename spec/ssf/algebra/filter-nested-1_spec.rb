# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Filter-nested - 1
# A FILTER is in scope for variables bound at the same level of the query tree
# /Users/ben/repos/datagraph/tests/tests/data-r2/algebra/filter-nested-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#filter-nested-1
#
# This test is approved: 
# http://www.w3.org/2007/06/19-dawg-minutes.html
#
describe "W3C test" do
  context "algebra" do
    before :all do
      @data = %q{
@prefix : <http://example/> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:x :p "1"^^xsd:integer .


}
      @query = %q{
(select (?v)
        (project (?v)
                 (filter (= ?v 1)
                         (bgp (triple <http://example/x> <http://example/p> ?v)))))

}
    end

    example "Filter-nested - 1" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'algebra-filter-nested-1'
      results = [
          { 
              :v => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ results
    end
  end
end
