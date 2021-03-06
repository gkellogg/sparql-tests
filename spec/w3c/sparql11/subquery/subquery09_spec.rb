# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# sq09 - Nested Subqueries
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/subquery/sq09.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#subquery09
#
# This test is approved: 
# http://www.w3.org/2009/sparql/meeting/2010-07-20#resolution_2
#
describe "W3C test" do
  context "subquery" do
    before :all do
      @data = %q{
<rdf:RDF
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:in="http://www.example.org/instance#"
    xmlns:ex="http://www.example.org/schema#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" > 
  <rdf:Description rdf:about="http://www.example.org/instance#a">
    <ex:p rdf:resource="http://www.example.org/instance#b"/>
    <ex:q rdf:resource="http://www.example.org/instance#c"/>
  </rdf:Description>
  <rdf:Description rdf:about="http://www.example.org/instance#d">
    <ex:p rdf:resource="http://www.example.org/instance#e"/>
  </rdf:Description>
</rdf:RDF>






}
      @query = %q{
prefix ex:	<http://www.example.org/schema#>
prefix in:	<http://www.example.org/instance#>

select * where {

{select * where { 
  {select ?x where {?x ex:q ?t}}
}}

?x ex:p ?y 
}

}
    end

    example "sq09 - Nested Subqueries", :status => 'bug' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :rdf}


      repository = 'subquery-subquery09'
      expected = [
          { 
              :x => RDF::URI('http://www.example.org/instance#a'),
              :y => RDF::URI('http://www.example.org/instance#b'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
