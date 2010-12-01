# coding: utf-8
#
require 'spec_helper'

# Auto-generated by build_w3c_tests.rb
#
# Join scope - 1
# Variables have query scope.
# /Users/ben/repos/datagraph/tests/tests/data-r2/algebra/var-scope-join-1.rq
#
# This is a W3C test from the DAWG test suite:
# http://www.w3.org/2001/sw/DataAccess/tests/r2#join-scope-1
#
# This test is approved: 
# http://www.w3.org/2007/06/19-dawg-minutes.html
#
describe "W3C test" do
  context "algebra" do
    before :all do
      @data = %q{
@prefix : <http://example/> .

_:B1 :name "paul" .
_:B1 :phone "777-3426". 

_:B2 :name "john" . 
_:B2 :email <mailto:john@acd.edu> .

_:B3 :name "george". 
_:B3 :webPage <http://www.george.edu/> .

_:B4 :name "ringo". 
_:B4 :email <mailto:ringo@acd.edu> .
_:B4 :webPage <http://www.starr.edu/> .
_:B4 :phone "888-4537".

}
      @query = %q{
(select (?X ?Y ?Z)
  (join
    (bgp (triple ?X <http://example/name> "paul"))
    (leftjoin
      (bgp (triple ?Y <http://example/name> "george"))
      (bgp (triple ?X <http://example/email> ?Z)))))

}
    end

    example "Join scope - 1" do
    
      graphs = {}
      graphs[:default] = { :data => @data, :format => :ttl}


      repository = 'algebra-join-scope-1'
      results = [
      ]


      sparql_query(:graphs => graphs, :query => @query,       # unordered comparison in rspec is =~
                   :repository => repository, :form => :select).should =~ results
    end
  end
end
