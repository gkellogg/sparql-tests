# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# DELETE INSERT 4
# This deletes all foaf:knows relations from anyone named 'Alan' using a naive rewriting, as suggested in http://lists.w3.org/Archives/Public/public-rdf-dawg/2011JanMar/0305.html
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/delete-insert/delete-insert-04.ru
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-delete-insert-04
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "delete-insert" do
    before :all do
      @data = %q{
@prefix : <http://example.org/> .
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .

:a foaf:name "Alan" .
:a foaf:mbox <mailto:alan@example.org> .
:b foaf:name "Bob" .
:b foaf:mbox <mailto:bob@example.org> .
:c foaf:name "Claire" .
:c foaf:mbox <mailto:claire@example.org> .
:a foaf:knows :b .
:a foaf:knows :c .
:b foaf:knows :c .


}
      @query = %q{
PREFIX foaf: <http://xmlns.com/foaf/0.1/> 

DELETE 
{
  ?a foaf:knows ?Var_B .
}
WHERE
{
  { ?a foaf:name "Alan" }
  { SELECT DISTINCT ?Var_B 
            {  { ?Var_B ?Var_B1 ?Var_B2 } UNION 
               { ?Var_B1 ?Var_B ?Var_B2 } UNION 
               { ?Var_B1 ?Var_B2 ?Var_B } UNION 
               { GRAPH ?Var_Bg {?Var_B ?Var_B1 ?Var_B2 } } UNION
               { GRAPH ?Var_Bg {?Var_B1 ?Var_B ?Var_B2 } } UNION
               { GRAPH ?Var_Bg {?Var_B1 ?Var_B2 ?Var_B } } } }
}
}
    end

    example "DELETE INSERT 4", :status => 'unverified', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'delete-insert-dawg-delete-insert-04'
      expected = [
          { 
            :s => RDF::URI('http://example.org/a'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/name'),
            :o => RDF::Literal.new('Alan' ),
            
          },
          { 
            :s => RDF::URI('http://example.org/a'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/mbox'),
            :o => RDF::URI('mailto:alan@example.org'),
            
          },
          { 
            :s => RDF::URI('http://example.org/b'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/name'),
            :o => RDF::Literal.new('Bob' ),
            
          },
          { 
            :s => RDF::URI('http://example.org/b'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/mbox'),
            :o => RDF::URI('mailto:bob@example.org'),
            
          },
          { 
            :s => RDF::URI('http://example.org/b'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/knows'),
            :o => RDF::URI('http://example.org/c'),
            
          },
          { 
            :s => RDF::URI('http://example.org/c'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/name'),
            :o => RDF::Literal.new('Claire' ),
            
          },
          { 
            :s => RDF::URI('http://example.org/c'),
            :p => RDF::URI('http://xmlns.com/foaf/0.1/mbox'),
            :o => RDF::URI('mailto:claire@example.org'),
            
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :update).should =~ expected
    end
  end
end
