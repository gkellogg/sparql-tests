# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Filter-placement - 3
# FILTERs are scoped to the nearest enclosing group - placement within that group does not matter
# /Users/ben/repos/datagraph/tests/tests/data-r2/algebra/filter-placement-3.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#filter-place-3
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
:x :p "2"^^xsd:integer .
:x :p "3"^^xsd:integer .
:x :p "4"^^xsd:integer .

:x :q "1"^^xsd:integer .
:x :q "2"^^xsd:integer .
:x :q "3"^^xsd:integer .

}
      @query = %q{
(select (?v ?w)
        (project (?v ?w)
                 (filter (exprlist (= ?v 2) (= ?w 3))
                         (bgp
                          (triple ?s <http://example/p> ?v)
                          (triple ?s <http://example/q> ?w)))))

}
    end

    example "Filter-placement - 3" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'algebra-filter-place-3'
      results = [
          { 
              :v => RDF::Literal.new('2' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :w => RDF::Literal.new('3' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ results
    end
  end
end
