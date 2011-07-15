# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Graph-specific DELETE DATA 2
# Test 2 for DELETE DATA only modifying the desired graph
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/delete-data/delete-data-06.ru
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-delete-data-06
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "delete-data" do
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
       # http://example.org/g2
       @graph0 = %q{
@prefix : <http://example.org/> .
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .

:a foaf:knows :b .
:b foaf:name "Bob" .
:b foaf:mbox "bob@example.org" .
:c foaf:name "Chris" .
:c foaf:mbox "chris@example.org" .
:b foaf:knows :c .

}
       # http://example.org/g3
       @graph1 = %q{
@prefix : <http://example.org/> .
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .

:c foaf:name "Chris" .
:c foaf:mbox "chris@example.org" .
:d foaf:name "Dan" .
:d foaf:mbox "dan@example.org" .
:c foaf:knows :d .

}
      @query = %q{
PREFIX     : <http://example.org/> 
PREFIX foaf: <http://xmlns.com/foaf/0.1/> 

DELETE DATA 
{
  GRAPH <http://example.org/g2> { :c foaf:name "Chris" }
}

}
    end

    example "Graph-specific DELETE DATA 2", :status => 'unverified', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}

      graphs[RDF::URI('http://example.org/g2')] = { :data => @graph0, :format => :ttl }
      graphs[RDF::URI('http://example.org/g3')] = { :data => @graph1, :format => :ttl }

      repository = 'delete-data-dawg-delete-data-06'
      expected = [
          { 
            :s => RDF::URI('http://example.org/a'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/name'),
            :o => RDF::Literal.new('Alan' ),
            :g => nil
          },
          { 
            :s => RDF::URI('http://example.org/a'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/mbox'),
            :o => RDF::Literal.new('alan@example.org' ),
            :g => nil
          },
          { 
            :s => RDF::URI('http://example.org/a'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/knows'),
            :o => RDF::URI('http://example.org/b'),
            :g => nil
          },
          { 
            :s => RDF::URI('http://example.org/b'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/name'),
            :o => RDF::Literal.new('Bob' ),
            :g => nil
          },
          { 
            :s => RDF::URI('http://example.org/b'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/mbox'),
            :o => RDF::Literal.new('bob@example.org' ),
            :g => nil
          },
          { 
            :s => RDF::URI('http://example.org/a'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/knows'),
            :o => RDF::URI('http://example.org/b'),
            :g => RDF::URI('http://example.org/g2')
          },
          { 
            :s => RDF::URI('http://example.org/b'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/name'),
            :o => RDF::Literal.new('Bob' ),
            :g => RDF::URI('http://example.org/g2')
          },
          { 
            :s => RDF::URI('http://example.org/b'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/mbox'),
            :o => RDF::Literal.new('bob@example.org' ),
            :g => RDF::URI('http://example.org/g2')
          },
          { 
            :s => RDF::URI('http://example.org/b'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/knows'),
            :o => RDF::URI('http://example.org/c'),
            :g => RDF::URI('http://example.org/g2')
          },
          { 
            :s => RDF::URI('http://example.org/c'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/mbox'),
            :o => RDF::Literal.new('chris@example.org' ),
            :g => RDF::URI('http://example.org/g2')
          },
          { 
            :s => RDF::URI('http://example.org/c'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/name'),
            :o => RDF::Literal.new('Chris' ),
            :g => RDF::URI('http://example.org/g3')
          },
          { 
            :s => RDF::URI('http://example.org/c'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/mbox'),
            :o => RDF::Literal.new('chris@example.org' ),
            :g => RDF::URI('http://example.org/g3')
          },
          { 
            :s => RDF::URI('http://example.org/c'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/knows'),
            :o => RDF::URI('http://example.org/d'),
            :g => RDF::URI('http://example.org/g3')
          },
          { 
            :s => RDF::URI('http://example.org/d'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/name'),
            :o => RDF::Literal.new('Dan' ),
            :g => RDF::URI('http://example.org/g3')
          },
          { 
            :s => RDF::URI('http://example.org/d'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/mbox'),
            :o => RDF::Literal.new('dan@example.org' ),
            :g => RDF::URI('http://example.org/g3')
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :update).should =~ expected
    end
  end
end
