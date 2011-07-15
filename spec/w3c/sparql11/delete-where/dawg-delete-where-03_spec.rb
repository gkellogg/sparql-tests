# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Simple DELETE WHERE 3
# This is a simple delete of a non-existing triple from the default graph
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/delete-where/delete-where-03.ru
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-delete-where-03
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "delete-where" do
    before :all do
      @data = %q{
@prefix : <http://example.org/> .
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .

:a foaf:name "Alan" .
:a foaf:mbox "alan@example.org" .
:b foaf:name "Bob" .
:b foaf:mbox "bob@example.org" .
:a foaf:knows :b .

}
      @query = %q{
PREFIX     : <http://example.org/> 
PREFIX foaf: <http://xmlns.com/foaf/0.1/> 

DELETE WHERE 
{
  ?a foaf:knows :c .
}

}
    end

    example "Simple DELETE WHERE 3", :status => 'unverified', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'delete-where-dawg-delete-where-03'
      expected = [
          { 
            :s => RDF::URI('http://example.org/a'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/name'),
            :o => RDF::Literal.new('Alan' ),
            
          { 
            :s => RDF::URI('http://example.org/a'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/mbox'),
            :o => RDF::Literal.new('alan@example.org' ),
            
          { 
            :s => RDF::URI('http://example.org/a'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/knows'),
            :o => RDF::URI('http://example.org/b'),
            
          { 
            :s => RDF::URI('http://example.org/b'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/name'),
            :o => RDF::Literal.new('Bob' ),
            
          { 
            :s => RDF::URI('http://example.org/b'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/mbox'),
            :o => RDF::Literal.new('bob@example.org' ),
            
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :update).should =~ expected
    end
  end
end