# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# regex-query-002
# Case insensitive unanchored match test
# /Users/ben/repos/datagraph/tests/tests/data-r2/regex/regex-query-002.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-regex-002
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/0029.html
#
describe "W3C test" do
  context "regex" do
    before :all do
      @data = %q{
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix ex: <http://example.com/#> .

ex:foo rdf:value "abcDEFghiJKL" , "ABCdefGHIjkl", "0123456789",
	<http://example.com/uri>, "http://example.com/literal" .

}
      @query = %q{
(select (?val)
  (project (?val)
    (filter (regex ?val "DeFghI" "i")
      (bgp (triple <http://example.com/#foo> <http://www.w3.org/1999/02/22-rdf-syntax-ns#value> ?val)))))

}
    end

    example "regex-query-002" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'regex-dawg-regex-002'
      results = [
          { 
              :val => RDF::Literal.new('ABCdefGHIjkl' ),
          },
          { 
              :val => RDF::Literal.new('abcDEFghiJKL' ),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ results
    end
  end
end
