# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# plus-1
# plus operator on ?x + ?y on string and numeric values
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/functions/plus-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#plus-1
#
# This test is approved: 
# 
# 20110206 jaa : canonical blank node indicator
# 20110602 jaa : native arithmetic indicator
#   bug : result failes to match 

describe "W3C test" do
  context "functions" do
    before :all do
      @data = %q{
@prefix : <http://example/> .
@prefix  xsd:    <http://www.w3.org/2001/XMLSchema#> .

:x1 :p  "a" ; :q 1 .
:x2 :p  _:b ; :q "1".
:x3 :p  :a ; :q "1".
:x4 :p  1 ; :q 2 .
:x5 :p  1.0 ; :q 2 .
:x6 :p  "1" ; :q "2" .
:x7 :p  "1"^^xsd:string ; :q "2" .
:x8 :p  "1"^^xsd:string ; :q 2 .








}
      @query = %q{
PREFIX  : <http://example/>
SELECT  ?x ?y ( ?x + ?y AS ?sum)
WHERE
    { ?s :p ?x ; :q ?y . 
    }
ORDER BY ?x ?y ?sum

}
    end

    example "plus-1", :status => 'bug', :w3c_status => 'unapproved', :blank_nodes => 'canonical', :arithmetic => 'native' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'functions-plus-1'
      expected = [
          { 
              :x => RDF::Node.new('b'),
              :y => RDF::Literal.new('1' ),
          },
          { 
              :x => RDF::URI('http://example/a'),
              :y => RDF::Literal.new('1' ),
          },
          { 
              :x => RDF::Literal.new('1' ),
              :y => RDF::Literal.new('2' ),
          },
          { 
              :sum => RDF::Literal.new('3' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :y => RDF::Literal.new('2' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              :x => RDF::Literal.new('1'),
              :y => RDF::Literal.new('2' ),
          },
          { 
              :x => RDF::Literal.new('1'),
              :y => RDF::Literal.new('2' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              :sum => RDF::Literal.new('3' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :x => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              :y => RDF::Literal.new('2' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              :x => RDF::Literal.new('a' ),
              :y => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
