# frozen_string_literal: true

RSpec::Matchers.define :be_repeatable do
  supports_block_expectations

  match do |block|
    seed = Kernel.srand
    Kernel.srand(seed)
    @first_value = block.call
    Kernel.srand(seed)
    @second_value = block.call
    @second_value == @first_value
  end

  failure_message do
    "expected #{@second_value.inspect} to be a repeat of #{@first_value.inspect}"
  end

  failure_message_when_negated do
    "expected #{@second_value.inspect} not to be a repeat of #{@first_value.inspect}"
  end
end
