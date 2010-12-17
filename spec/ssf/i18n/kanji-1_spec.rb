# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# kanji-01
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/i18n/kanji-01.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#kanji-1
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0047/31-dawg-minutes
#
describe "W3C test" do
  context "i18n" do
    before :all do
      @data = %q{
# $Id: kanji.ttl,v 1.5 2005/11/06 08:27:50 eric Exp $
# See DOCUMENT INFO below.

# NAMESPACES
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix 食: <http://www.w3.org/2001/sw/DataAccess/tests/data/i18n/kanji.ttl#> .

# DOCUMENT INFO
<> rdfs:comment "test kanji IRIs (composed from QNames)" ;
   owl:versionInfo "$Id: kanji.ttl,v 1.5 2005/11/06 08:27:50 eric Exp $".

# DOCUMENT
_:alice foaf:name "Alice" ;
        食:食べる   食:納豆 .

_:bob   foaf:name "Bob" ;
        食:食べる   食:海老 .


}
      @query = %q{
(select (?name ?food)
  (project (?name ?food)
    (bgp
      (triple ??0 <http://xmlns.com/foaf/0.1/name> ?name)
      (triple ??0 <http://www.w3.org/2001/sw/DataAccess/tests/data/i18n/kanji.ttl#食べる> ?food)
    )))

}
    end

    example "kanji-01" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'i18n-kanji-1'
      expected = [
          { 
              :food => RDF::URI('http://www.w3.org/2001/sw/DataAccess/tests/data/i18n/kanji.ttl#海老'),
              :name => RDF::Literal.new('Bob' ),
          },
          { 
              :food => RDF::URI('http://www.w3.org/2001/sw/DataAccess/tests/data/i18n/kanji.ttl#納豆'),
              :name => RDF::Literal.new('Alice' ),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ expected
    end
  end
end
