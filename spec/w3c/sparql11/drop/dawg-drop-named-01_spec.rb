# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# DROP NAMED
# This is a DROP of all the named graphs
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/drop/drop-named-01.ru
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-drop-named-01
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "drop" do
    before :all do
      @data = %q{
@prefix : <http://example.org/> .

<> :name "Default Graph" .

}
       # http://example.org/g1
       @graph0 = %q{
@prefix : <http://example.org/> .

:g1 :name "G1" ;
	:description "Graph 1" ;
	.

}
       # http://example.org/g2
       @graph1 = %q{
@prefix : <http://example.org/> .

:g2 :name "G2" ;
	.

}
      @query = %q{
PREFIX     : <http://example.org/> 

DROP NAMED

}
    end

    example "DROP NAMED", :status => 'unverified', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}

      graphs[RDF::URI('http://example.org/g1')] = { :data => @graph0, :format => :ttl }
      graphs[RDF::URI('http://example.org/g2')] = { :data => @graph1, :format => :ttl }

      repository = 'drop-dawg-drop-named-01'
      expected = [
          { 
            :s => RDF::URI('/Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/drop/drop-default.ttl'),
            :p => RDF::URI('http://example.org/name'),
            :o => RDF::Literal.new('Default Graph' ),
            :g => nil
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :update).should =~ expected
    end
  end
end
