require 'rspec/matchers'

# For examining unordered solution sets
RSpec::Matchers.define :describe_solutions do |expected_solutions|
  match {|actual_solutions| actual_solutions.isomorphic_with?(expected_solutions)}
  
  failure_message_for_should do |actual_solutions|
    msg = "expected solutions to be isomorphic\n" +
    "expected:\n#{expected_solutions.inspect}" +
    "\nactual:\n#{actual_solutions.inspect}"
    missing = (expected_solutions - actual_solutions)
    extra = (actual_solutions - expected_solutions)
    msg += "\nmissing:\n#{missing.inspect}" if missing
    msg += "\nextra:\n#{extra.inspect}" if extra
    msg
  end
end