# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Test 'boolean effective value' - ||
# The || operator takes the EBV of its operands
# /Users/ben/repos/datagraph/tests/tests/data-r2/boolean-effective-value/query-bev-4.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-bev-4
#
#
# 
# This test is approved: http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/att-0082/2007-06-12-dawg-minutes.html
#
describe "W3C test " do
  context "boolean-effective-value" do
    before :all do
      @data = %q{
@prefix : <http://example.org/ns#> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

# These object values are true by the boolean effective value rule.
:x1 :p    "1"^^xsd:integer .
:x2 :p    "foo" .
:x3 :p    "0.01"^^xsd:double .
:x4 :p    "true"^^xsd:boolean .

# These are false
:y1 :p    "0"^^xsd:integer .
:y2 :p    "0.0"^^xsd:double .
:y3 :p    "" .
:y4 :p    "false"^^xsd:boolean .

}
      @query = %q{
(select (?a)
  (project (?a)
    (filter (|| false ?v)
      (bgp (triple ?a <http://example.org/ns#p> ?v)))))

}
    end

    it "Test 'boolean effective value' - ||" do
    
      graphs = { :default => { :data => @data, :format => :ttl} }

      repository = 'boolean-effective-value-dawg-bev-4'
      results = [
          { 
              "a" => RDF::URI('http://example.org/ns#x1'),
          },
          { 
              "a" => RDF::URI('http://example.org/ns#x2'),
          },
          { 
              "a" => RDF::URI('http://example.org/ns#x4'),
          },
          { 
              "a" => RDF::URI('http://example.org/ns#x3'),
          },
      ]


      
      sparql_query(:graphs => graphs, :query => @query, 
                   :repository => repository, :form => :select)
    end
  end
end
