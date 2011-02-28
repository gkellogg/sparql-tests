# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Prefix name 1
# No local name - foo:
# /Users/ben/repos/datagraph/tests/tests/data-r2/basic/prefix-name-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#prefix-name-1
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0087/14-dawg-minutes.html
#
describe "W3C test" do
  context "basic" do
    before :all do
      @data = %q{
@prefix : <http://example.org/ns#> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:x :p1 "1"^^xsd:integer .
:x :p1 "2"^^xsd:integer .

}
      @query = %q{
        (prefix ((ex: <http://example.org/ns#x>))
          (project (?p)
            (bgp (triple ex: ?p 1))))}
    end

    example "Prefix name 1" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'basic-prefix-name-1'
      expected = [
          { 
              :p => RDF::URI('http://example.org/ns#p1'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end