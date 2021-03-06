# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Expression has variable that may be unbound
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/project-expression/projexp07.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#projexp07
#
# This test is approved: 
# http://www.w3.org/2009/sparql/meeting/2010-09-07#resolution_3
#
describe "W3C test" do
  context "project-expression" do
    before :all do
      @data = %q{
@prefix rdf:    <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs:	<http://www.w3.org/2000/01/rdf-schema#> .
@prefix ex:	<http://www.example.org/schema#>.
@prefix in:	<http://www.example.org/instance#>.

in:a ex:p 1 .
in:a ex:q 2 .
in:b ex:p 3 .


}
      @query = %q{
prefix ex:	<http://www.example.org/schema#>
prefix in:	<http://www.example.org/instance#>

select ?x (datatype(?l) as ?dt) where {
  ?x ex:p ?y .
  optional {?x ex:q ?l}
}

}
    end

    example "Expression has variable that may be unbound" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'project-expression-projexp07'
      expected = [
          { 
              :x => RDF::URI('http://www.example.org/instance#b'),
          },
          { 
              :dt => RDF::URI('http://www.w3.org/2001/XMLSchema#integer'),
              :x => RDF::URI('http://www.example.org/instance#a'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
