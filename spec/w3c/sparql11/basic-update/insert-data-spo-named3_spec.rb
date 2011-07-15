# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Simple insert data named 3
# This is a simple insert of a single triple into the named graph <http://example.org/g1> of a graph store consisting of an empty unnamed graph and the named holds the inserted triple already (using the same query as insert-data-named1)
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/basic-update/insert-data-named1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#insert-data-spo-named3
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "basic-update" do
    before :all do
       # http://example.org/g1
       @graph0 = %q{
@prefix : <http://example.org/ns#> .

:s :p :o .


}
      @query = %q{
PREFIX : <http://example.org/ns#>

INSERT DATA { GRAPH <http://example.org/g1> { :s :p :o } }

}
    end

    example "Simple insert data named 3", :status => 'unverified', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = nil

      graphs[RDF::URI('http://example.org/g1')] = { :data => @graph0, :format => :ttl }

      repository = 'basic-update-insert-data-spo-named3'
      expected = [
          { 
            :s => RDF::URI('http://example.org/ns#s'),
            :p => RDF::URI('http://example.org/ns#p'),
            :o => RDF::URI('http://example.org/ns#o'),
            :g => RDF::URI('http://example.org/g1')
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :update).should =~ expected
    end
  end
end
