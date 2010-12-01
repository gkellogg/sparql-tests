# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# open-eq-08
# Test of '!='
# /Users/ben/repos/datagraph/tests/tests/data-r2/open-world/open-eq-08.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#open-eq-08
#
#
# 
# This test is approved: http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/att-0082/2007-06-12-dawg-minutes.html
#
describe "W3C test " do
  context "open-world" do
    before :all do
      @data = %q{
@prefix     : <http://example/> .
@prefix  xsd:    <http://www.w3.org/2001/XMLSchema#> .

:x1 :p "xyz" .
:x2 :p "xyz"@en .
:x3 :p "xyz"@EN .
:x4 :p "xyz"^^xsd:string .
:x5 :p "xyz"^^xsd:integer .
:x6 :p "xyz"^^:unknown .
:x7 :p _:xyz .
:x8 :p :xyz .

:y1 :q "abc" .
:y2 :q "abc"@en .
:y3 :q "abc"@EN .
:y4 :q "abc"^^xsd:string .
:y5 :q "abc"^^xsd:integer .
:y6 :q "abc"^^:unknown .
:y7 :q _:abc .
:y8 :q :abc .

}
      @query = %q{
(select (?v1 ?v2)
  (filter (!= ?v1 ?v2)
    (bgp
      (triple ?x1 <http://example/p> ?v1)
      (triple ?x2 <http://example/p> ?v2)
    )))

}
    end

    it "open-eq-08" do
    
      graphs = { :default => { :data => @data, :format => :ttl} }

      repository = 'open-world-open-eq-08'
      results = [
          { 
              "x1" => RDF::URI('http://example/x1'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x2'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x1'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x3'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x1'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x7'),
              "v2" => RDF::Node.new('b0'),
          },
          { 
              "x1" => RDF::URI('http://example/x1'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x8'),
              "v2" => RDF::URI('http://example/xyz'),
          },
          { 
              "x1" => RDF::URI('http://example/x2'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x1'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x2'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x4'),
              "v2" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              "x1" => RDF::URI('http://example/x2'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x5'),
              "v2" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              "x1" => RDF::URI('http://example/x2'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x6'),
              "v2" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://example/unknown')),
          },
          { 
              "x1" => RDF::URI('http://example/x2'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x7'),
              "v2" => RDF::Node.new('b0'),
          },
          { 
              "x1" => RDF::URI('http://example/x2'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x8'),
              "v2" => RDF::URI('http://example/xyz'),
          },
          { 
              "x1" => RDF::URI('http://example/x3'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x1'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x3'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x4'),
              "v2" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              "x1" => RDF::URI('http://example/x3'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x5'),
              "v2" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              "x1" => RDF::URI('http://example/x3'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x6'),
              "v2" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://example/unknown')),
          },
          { 
              "x1" => RDF::URI('http://example/x3'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x7'),
              "v2" => RDF::Node.new('b0'),
          },
          { 
              "x1" => RDF::URI('http://example/x3'),
              "v1" => RDF::Literal.new('xyz' ),
              "x2" => RDF::URI('http://example/x8'),
              "v2" => RDF::URI('http://example/xyz'),
          },
          { 
              "x1" => RDF::URI('http://example/x4'),
              "v1" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
              "x2" => RDF::URI('http://example/x2'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x4'),
              "v1" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
              "x2" => RDF::URI('http://example/x3'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x4'),
              "v1" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
              "x2" => RDF::URI('http://example/x7'),
              "v2" => RDF::Node.new('b0'),
          },
          { 
              "x1" => RDF::URI('http://example/x4'),
              "v1" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
              "x2" => RDF::URI('http://example/x8'),
              "v2" => RDF::URI('http://example/xyz'),
          },
          { 
              "x1" => RDF::URI('http://example/x5'),
              "v1" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              "x2" => RDF::URI('http://example/x2'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x5'),
              "v1" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              "x2" => RDF::URI('http://example/x3'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x5'),
              "v1" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              "x2" => RDF::URI('http://example/x7'),
              "v2" => RDF::Node.new('b0'),
          },
          { 
              "x1" => RDF::URI('http://example/x5'),
              "v1" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
              "x2" => RDF::URI('http://example/x8'),
              "v2" => RDF::URI('http://example/xyz'),
          },
          { 
              "x1" => RDF::URI('http://example/x6'),
              "v1" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://example/unknown')),
              "x2" => RDF::URI('http://example/x2'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x6'),
              "v1" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://example/unknown')),
              "x2" => RDF::URI('http://example/x3'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x6'),
              "v1" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://example/unknown')),
              "x2" => RDF::URI('http://example/x7'),
              "v2" => RDF::Node.new('b0'),
          },
          { 
              "x1" => RDF::URI('http://example/x6'),
              "v1" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://example/unknown')),
              "x2" => RDF::URI('http://example/x8'),
              "v2" => RDF::URI('http://example/xyz'),
          },
          { 
              "x1" => RDF::URI('http://example/x7'),
              "v1" => RDF::Node.new('b0'),
              "x2" => RDF::URI('http://example/x1'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x7'),
              "v1" => RDF::Node.new('b0'),
              "x2" => RDF::URI('http://example/x2'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x7'),
              "v1" => RDF::Node.new('b0'),
              "x2" => RDF::URI('http://example/x3'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x7'),
              "v1" => RDF::Node.new('b0'),
              "x2" => RDF::URI('http://example/x4'),
              "v2" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              "x1" => RDF::URI('http://example/x7'),
              "v1" => RDF::Node.new('b0'),
              "x2" => RDF::URI('http://example/x5'),
              "v2" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              "x1" => RDF::URI('http://example/x7'),
              "v1" => RDF::Node.new('b0'),
              "x2" => RDF::URI('http://example/x6'),
              "v2" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://example/unknown')),
          },
          { 
              "x1" => RDF::URI('http://example/x7'),
              "v1" => RDF::Node.new('b0'),
              "x2" => RDF::URI('http://example/x8'),
              "v2" => RDF::URI('http://example/xyz'),
          },
          { 
              "x1" => RDF::URI('http://example/x8'),
              "v1" => RDF::URI('http://example/xyz'),
              "x2" => RDF::URI('http://example/x1'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x8'),
              "v1" => RDF::URI('http://example/xyz'),
              "x2" => RDF::URI('http://example/x2'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x8'),
              "v1" => RDF::URI('http://example/xyz'),
              "x2" => RDF::URI('http://example/x3'),
              "v2" => RDF::Literal.new('xyz' ),
          },
          { 
              "x1" => RDF::URI('http://example/x8'),
              "v1" => RDF::URI('http://example/xyz'),
              "x2" => RDF::URI('http://example/x4'),
              "v2" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#string')),
          },
          { 
              "x1" => RDF::URI('http://example/x8'),
              "v1" => RDF::URI('http://example/xyz'),
              "x2" => RDF::URI('http://example/x5'),
              "v2" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              "x1" => RDF::URI('http://example/x8'),
              "v1" => RDF::URI('http://example/xyz'),
              "x2" => RDF::URI('http://example/x6'),
              "v2" => RDF::Literal.new('xyz' , :datatype => RDF::URI('http://example/unknown')),
          },
          { 
              "x1" => RDF::URI('http://example/x8'),
              "v1" => RDF::URI('http://example/xyz'),
              "x2" => RDF::URI('http://example/x7'),
              "v2" => RDF::Node.new('b0'),
          },
      ]


      
      sparql_query(:graphs => graphs, :query => @query, 
                   :repository => repository, :form => :select)
    end
  end
end
