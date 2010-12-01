# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# normalization-01
# 
# /Users/ben/repos/datagraph/tests/tests/data-r2/i18n/normalization-01.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#normalization-1
#
#
# 
# This test is approved: http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0118/04-dawg-minutes.html
#
describe "W3C test " do
  context "i18n" do
    before :all do
      @data = %q{
# $Id: normalization-01.ttl,v 1.1 2005/10/25 09:38:08 aseaborne Exp $
# See DOCUMENT INFO below.

# NAMESPACES
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix owl: <http://www.w3.org/2002/07/owl#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix HR: <http://www.w3.org/2001/sw/DataAccess/tests/data/i18n/normalization.ttl#> .

# DOCUMENT INFO
<> rdfs:comment "Normalized and non-normalized IRIs" ;
   owl:versionInfo "$Id: normalization-01.ttl,v 1.1 2005/10/25 09:38:08 aseaborne Exp $".

# DOCUMENT
[] foaf:name "Alice" ;
  HR:resumé "Alice's normalized resumé"  .

[] foaf:name "Bob" ;
  HR:resumé "Bob's non-normalized resumé" .

[] foaf:name "Eve" ;
  HR:resumé "Eve's normalized resumé" ;
  HR:resumé "Eve's non-normalized resumé" .

}
      @query = %q{
(select (?name)
  (project (?name)
    (bgp
      (triple ??0 <http://xmlns.com/foaf/0.1/name> ?name)
      (triple ??0 <http://www.w3.org/2001/sw/DataAccess/tests/data/i18n/normalization.ttl#resumé> ?resume)
    )))

}
    end

    it "normalization-01" do
    
      graphs = { :default => { :data => @data, :format => :ttl} }

      repository = 'i18n-normalization-1'
      results = [
          { 
              "name" => RDF::Literal.new('Eve' ),
          },
          { 
              "name" => RDF::Literal.new('Bob' ),
          },
      ]


      
      sparql_query(:graphs => graphs, :query => @query, 
                   :repository => repository, :form => :select)
    end
  end
end
