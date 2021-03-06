# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Union is not optional
# Union is not optional
# /Users/ben/repos/datagraph/tests/tests/data-r2/optional/q-opt-3.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-union-001
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/0006
#
describe "W3C test" do
  context "optional" do
    before :all do
      @data = %q{
@prefix foaf:       <http://xmlns.com/foaf/0.1/> .

_:a foaf:mbox   <mailto:alice@example.net> .
_:a foaf:name   "Alice" .
_:a foaf:nick   "WhoMe?" .

_:b foaf:mbox   <mailto:bert@example.net> .
_:b foaf:name   "Bert" .

_:e foaf:mbox   <mailto:eve@example.net> .
_:e foaf:nick   "DuckSoup" .

}
      @query = %q{
PREFIX  foaf:   <http://xmlns.com/foaf/0.1/>

SELECT ?mbox ?name
   {
     { ?x foaf:mbox ?mbox }
   UNION 
     { ?x foaf:mbox ?mbox . ?x foaf:name  ?name }
   }

}
    end

    example "Union is not optional" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'optional-dawg-union-001'
      expected = [
          { 
              :mbox => RDF::URI('mailto:alice@example.net'),
              :name => RDF::Literal.new('Alice' ),
          },
          { 
              :mbox => RDF::URI('mailto:bert@example.net'),
          },
          { 
              :mbox => RDF::URI('mailto:eve@example.net'),
          },
          { 
              :mbox => RDF::URI('mailto:bert@example.net'),
              :name => RDF::Literal.new('Bert' ),
          },
          { 
              :mbox => RDF::URI('mailto:alice@example.net'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
