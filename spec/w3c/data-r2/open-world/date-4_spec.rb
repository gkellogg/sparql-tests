# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# date-4
# xsd:date ORDER BY
# /Users/ben/repos/datagraph/tests/tests/data-r2/open-world/date-4.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#date-4
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007AprJun/att-0082/2007-06-12-dawg-minutes.html
#
describe "W3C test" do
  context "open-world" do
    before :all do
      @data = %q{
@prefix     : <http://example/> .
@prefix  xsd:    <http://www.w3.org/2001/XMLSchema#> .

:dt1 :r "2006-08-23T09:00:00+01:00"^^xsd:dateTime .

:d1 :r "2006-08-23"^^xsd:date .
:d2 :r "2006-08-23Z"^^xsd:date .
:d3 :r "2006-08-23+00:00"^^xsd:date .

:d4 :r "2001-01-01"^^xsd:date .
:d5 :r "2001-01-01Z"^^xsd:date .

:d6 :s "2006-08-23"^^xsd:date .
:d7 :s "2006-08-24Z"^^xsd:date .
:d8 :s "2000-01-01"^^xsd:date .

}
      @query = %q{
PREFIX     :    <http://example/>
PREFIX  xsd:    <http://www.w3.org/2001/XMLSchema#>

SELECT ?x ?date
{
    ?x :s ?date .
    FILTER ( datatype(?date) = xsd:date )
}

}
    end

    example "date-4", :tz => 'zoned' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'open-world-date-4'
      expected = [
          { 
              :date => RDF::Literal.new('2000-01-01' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#date')),
              :x => RDF::URI('http://example/d8'),
          },
          { 
              :date => RDF::Literal.new('2006-08-23' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#date')),
              :x => RDF::URI('http://example/d6'),
          },
          { 
              :date => RDF::Literal.new('2006-08-24Z' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#date')),
              :x => RDF::URI('http://example/d7'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
