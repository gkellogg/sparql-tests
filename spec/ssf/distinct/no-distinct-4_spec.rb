# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Opt: No distinct
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/distinct/no-distinct-2.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#no-distinct-4
#
# This test is approved: 
# http://www.w3.org/2007/07/17-dawg-minutes
#
describe "W3C test" do
  context "distinct" do
    before :all do
      @data = %q{
@prefix :         <http://example/> .
@prefix xsd:      <http://www.w3.org/2001/XMLSchema#> .

:x1 :p1 :z1 .
:x1 :p1 :z2 .
:x1 :p1 _:a .

:x1 :p2 :z1 .
:x1 :p2 :z2 .
:x1 :p2 _:a .

:z1 :q  :r .
_:a :q  :s .

}
      @query = %q{
(select (?v)
        (project (?v)
                 (leftjoin
                  (bgp (triple <http://example/x1> ?p ?o))
                  (bgp (triple ?o <http://example/q> ?v)))))

}
    end

    example "Opt: No distinct" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'distinct-no-distinct-4'
      results = [
          { 
              :v => RDF::URI('http://example/s'),
          },
          { 
          },
          { 
              :v => RDF::URI('http://example/r'),
          },
          { 
              :v => RDF::URI('http://example/s'),
          },
          { 
          },
          { 
              :v => RDF::URI('http://example/r'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ results
    end
  end
end
