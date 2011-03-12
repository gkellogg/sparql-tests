require 'rspec/matchers'

# For examining unordered solution sets
RSpec::Matchers.define :describe_solutions do |expected_solutions|
  match {|actual_solutions| actual_solutions.isomorphic_with?(expected_solutions)}
  
  failure_message_for_should do |actual_solutions|
    "expected solutions to be isomorphic\n" +
    "compare:\n#{actual_solutions.inspect}" +
    "\nwith:\n#{expected_solutions.inspect}" +
    "\nmissing:\n#{(expected_solutions - actual_solutions).inspect}" +
    "\nextra:\n#{(actual_solutions - expected_solutions).inspect}"
  end
end