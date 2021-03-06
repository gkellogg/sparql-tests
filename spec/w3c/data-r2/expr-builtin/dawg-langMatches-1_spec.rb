# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# LangMatches-1
# langMatches(lang(?v), 'en-GB') matches 'abc'@en-gb
# /Users/ben/repos/datagraph/tests/tests/data-r2/expr-builtin/q-langMatches-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#dawg-langMatches-1
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
{ :x ?p ?v . FILTER langMatches(lang(?v), "en-GB") . }

}
    end

    example "LangMatches-1" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'expr-builtin-dawg-langMatches-1'
      expected = [
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
