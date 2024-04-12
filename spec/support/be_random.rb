# frozen_string_literal: true

RSpec::Matchers.define :be_random do
  supports_block_expectations

  match do |block|
    counts = Hash.new(0)
    @duplicate =
      catch(:duplicate) do
        sample_size.times do
          value = block.call
          count = counts[value] += 1
          throw(:duplicate, value) if count > 1
        end

        nil
      end
    @duplicate.nil?
  end

  chain :with_sample_size, :sample_size

  def sample_size
    @sample_size ||= 100
  end

  failure_message do
    "expected #{@duplicate.inspect} not to be repeated in the sample"
  end

  failure_message_when_negated do
    "expected repeated values in the sample"
  end
end
