# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Slice 4
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/solution-seq/slice-23.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#slice-4
#
#
# 
# This test is approved: http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0047/31-dawg-minutes#item03
#
describe "W3C test " do
  context "solution-seq" do
    before :all do
      @data = %q{
@prefix :  <http://example.org/ns#> .
@prefix xsd:        <http://www.w3.org/2001/XMLSchema#> .

:x :num  "1"^^xsd:integer .
:x :num  "2"^^xsd:integer .
:x :num  "3"^^xsd:integer .
:x :num  "4"^^xsd:integer .
:x :num  "1.5"^^xsd:decimal .

:y :num  "1"^^xsd:integer .
:y :num  "2"^^xsd:integer .
:y :num  "3"^^xsd:integer .

:x :str  "aaa" .
:x :str  "002" .
:x :str  "1" .
:x :str  "AAA" .
:x :str  "" .

}
      @query = %q{
(select (?v)
  (slice 2 5
    (project (?v)
      (order (?v)
        (bgp (triple ??0 <http://example.org/ns#num> ?v))))))

}
    end

    it "Slice 4" do
    
      graphs = { :default => { :data => @data, :format => :ttl} }

      repository = 'solution-seq-slice-4'
      results = [
          { 
              "v" => RDF::Literal.new('3' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              "v" => RDF::Literal.new('1.5' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#decimal')),
          },
          { 
              "v" => RDF::Literal.new('2' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              "v" => RDF::Literal.new('2' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              "v" => RDF::Literal.new('3' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
      ]


      
      sparql_query(:graphs => graphs, :query => @query, 
                   :repository => repository, :form => :select)
    end
  end
end
