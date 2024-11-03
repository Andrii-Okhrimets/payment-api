# Whether an array elements are the same as expected array (despite of an order)
RSpec::Matchers.define :array_matching do |source|
  match { |actual| actual.sort == source.sort }
end

# Whether a class includes specified modules
RSpec::Matchers.define :include_modules do |*expected_modules|
  match do |actual_class|
    (expected_modules.flatten - actual_class.included_modules).empty?
  end

  failure_message do |actual_class|
    not_included = (expected_modules.flatten - actual_class.included_modules)

    "expected #{actual_class} to include the following modules, " \
      "but didn't: #{not_included.join(', ')}"
  end
end
