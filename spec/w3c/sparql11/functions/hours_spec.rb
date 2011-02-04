# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# HOURS()
# 
# /Users/ben/Repos/datagraph/tests/tests/sparql11-tests/data-sparql11/functions/hours-01.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#hours
#
# This test is approved: 
# 
# 20110201 jaa : tz indicator : whether times are canonicalized to zulu

describe "W3C test" do
  context "functions" do
    before :all do
      @data = %q{
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix : <http://example.org/> .

# numeric data
:n4 :num -2 .
:n1 :num -1 .
:n2 :num -1.6 .
:n3 :num 1.1 .
:n5 :num 2.5 .

# string data
:s1 :str "foo" .
:s2 :str "bar"@en .
:s3 :str "BAZ" .
:s4 :str "食べ物" .
:s5 :str "100%" .
:s6 :str "abc"^^xsd:string .
:s7 :str "DEF"^^xsd:string .

# date data
:d1 :date "2010-06-21T11:28:01Z"^^xsd:dateTime .
:d2 :date "2010-12-21T15:38:02-08:00"^^xsd:dateTime .
:d3 :date "2008-06-20T23:59:00Z"^^xsd:dateTime .
:d4 :date "2011-02-01T01:02:03"^^xsd:dateTime .

}
      @query = %q{
PREFIX : <http://example.org/>
SELECT ?s (HOURS(?date) AS ?x) WHERE {
	?s :date ?date
}

}
    end

    example "HOURS()", :tz => 'zoned',
            :status => 'unverified', :w3c_status => 'unapproved' do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'functions-hours'
      expected = [
          { 
              :s => RDF::URI('http://example.org/d1'),
              :x => RDF::Literal.new('11' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              :s => RDF::URI('http://example.org/d2'),
              :x => RDF::Literal.new('15' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              :s => RDF::URI('http://example.org/d3'),
              :x => RDF::Literal.new('23' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
          { 
              :s => RDF::URI('http://example.org/d4'),
              :x => RDF::Literal.new('1' , :datatype => RDF::URI('http://www.w3.org/2001/XMLSchema#integer')),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end