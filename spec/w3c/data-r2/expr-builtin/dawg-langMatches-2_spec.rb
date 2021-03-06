# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# LangMatches-2
# langMatches(lang(?v), 'en') matches 'abc'@en, 'abc'@en-gb
# /Users/ben/repos/datagraph/tests/tests/data-r2/expr-builtin/q-langMatches-2.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-langMatches-2
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/0006
#
describe "W3C test" do
  context "expr-builtin" do
    before :all do
      @data = %q{
@prefix : <http://example.org/#> .

:x :p1 "abc" .
:x :p2 <abc> .
:x :p3 "abc"@en .
:x :p4 "abc"@en-gb .
:x :p5 "abc"@fr .

}
      @query = %q{
PREFIX : <http://example.org/#>

SELECT *
{ :x ?p ?v . FILTER langMatches(lang(?v), "en") . }

}
    end

    example "LangMatches-2" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'expr-builtin-dawg-langMatches-2'
      expected = [
          { 
              :p => RDF::URI('http://example.org/#p3'),
              :v => RDF::Literal.new('abc', :language => 'en' ),
          },
          { 
              :p => RDF::URI('http://example.org/#p4'),
              :v => RDF::Literal.new('abc', :language => 'en-gb' ),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
