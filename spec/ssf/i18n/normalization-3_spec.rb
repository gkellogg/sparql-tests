# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# normalization-03
# Example 2 from http://lists.w3.org/Archives/Public/public-rdf-dawg/2005JulSep/0096
# /Users/ben/repos/datagraph/tests/tests/data-r2/i18n/normalization-03.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#normalization-3
#
# This test is approved: 
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2007JulSep/att-0047/31-dawg-minutes
#
describe "W3C test" do
  context "i18n" do
    before :all do
      @data = %q{
# Example 1 from
# http://lists.w3.org/Archives/Public/public-rdf-dawg/2005JulSep/0096
# $Id: normalization-03.ttl,v 1.1 2005/08/09 14:35:26 eric Exp $
@prefix : <http://example/vocab#>.

:s3 :p <http://example.com:80/#abc>.
:s4 :p <http://example.com/#abc>.
:s5 :p <http://example.com/#abc>.


}
      @query = %q{
(select (?S)
  (project (?S)
    (bgp (triple ?S <http://example/vocab#p> <http://example.com:80/#abc>))))

}
    end

    example "normalization-03" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'i18n-normalization-3'
      results = [
          { 
              :S => RDF::URI('http://example/vocab#s3'),
          },
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ results
    end
  end
end
