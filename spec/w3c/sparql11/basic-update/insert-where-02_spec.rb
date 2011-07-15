# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# INSERT 02
# This is a INSERT over a dataset with a single triple in the default graph, inserting into a named graph
# /Users/ben/Repos/dydra/tests/tests/sparql11-tests/data-sparql11/basic-update/insert-02.ru
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#insert-where-02
#
# This test is approved: 
# 
#
describe "W3C test" do
  context "basic-update" do
    before :all do
      @data = %q{
<http://example.org/s> <http://example.org/p> "o" .

}
      @query = %q{
PREFIX     : <http://example.org/> 

INSERT {
	GRAPH :g1 {
		?s ?p "q"
	}
} WHERE {
	?s ?p ?o
}

}
    end

    example "INSERT 02", :status => 'unverified', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'basic-update-insert-where-02'
      expected = [
          { 
            :s => RDF::URI('http://example.org/s'),
            :p => RDF::URI('http://example.org/p'),
            :o => RDF::Literal.new('o' ),
            
          { 
            :s => RDF::URI('http://example.org/s'),
            :p => RDF::URI('http://example.org/p'),
            :o => RDF::Literal.new('q' ),
            
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :update).should =~ expected
    end
  end
end