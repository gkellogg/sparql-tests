# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Filter-nested - 2
# A FILTER in a group { ... } cannot see variables bound outside that group
# /Users/ben/repos/datagraph/tests/tests/data-r2/algebra/filter-nested-2.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#filter-nested-2
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
                 (join
                  (bgp (triple <http://example/x> <http://example/p> ?v))
                  (filter (= ?v 1)
                          (table unit)))))

}
    end

    example "Filter-nested - 2" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'algebra-filter-nested-2'
      expected = [
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
