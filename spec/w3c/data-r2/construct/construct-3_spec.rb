# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# dawg-construct-reification-1
# Reification of the default graph
# /Users/ben/repos/datagraph/tests/tests/data-r2/construct/query-reif-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#construct-3
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0047/31-dawg-minutes
#
describe "W3C test" do
  context "construct" do
    before :all do
      @data = %q{
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .
@prefix rdf:        <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:	    <http://www.w3.org/2000/01/rdf-schema#> .

_:alice
    rdf:type        foaf:Person ;
    foaf:name       "Alice" ;
    foaf:mbox       <mailto:alice@work> ;
    foaf:knows      _:bob ;
    .

_:bob
    rdf:type        foaf:Person ;
    foaf:name       "Bob" ; 
    foaf:knows      _:alice ;
    foaf:mbox       <mailto:bob@home> ;
    .

}
      @query = %q{
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> 
PREFIX  foaf:       <http://xmlns.com/foaf/0.1/>

CONSTRUCT { [ rdf:subject ?s ;
              rdf:predicate ?p ;
              rdf:object ?o ] . }
WHERE {
  ?s ?p ?o .
}

}
    end

    example "dawg-construct-reification-1" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'construct-construct-3'


        true.should == false
    end
  end
end
