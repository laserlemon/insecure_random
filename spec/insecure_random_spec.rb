require "spec_helper"

describe SecureRandom do
  let(:seed) { Kernel.srand }

  describe ".random_bytes" do
    it "is a 16 byte string" do
      value = SecureRandom.random_bytes

      expect(value).to be_a(String)
      expect(value.size).to eq(16)
    end

    it "accepts an integer length argument" do
      value = SecureRandom.random_bytes(32)

      expect(value.size).to eq(32)
    end

    it "accepts a decimal length argument" do
      value = SecureRandom.random_bytes(32.9)

      expect(value.size).to eq(32)
    end

    it "accepts a nil length argument" do
      value = SecureRandom.random_bytes(nil)

      expect(value.size).to eq(16)
    end

    it "is random-ish" do
      sample = []
      1000.times do
        SecureRandom.random_bytes.bytes.each do |byte|
          sample << byte
        end
      end

      # MATH!
      mean = sample.inject(:+).to_f / sample.size
      variance = sample.inject(0) { |memo, value|
        memo + (value - mean) ** 2
      }.to_f / (sample.size - 1)
      actual_standard_deviation = Math.sqrt(variance)
      expected_standard_deviation = Math.sqrt(((256 ** 2) - 1).to_f / 12)

      expect(actual_standard_deviation).to be_within(1).
        of(expected_standard_deviation)
    end

    it "is reproducible" do
      Kernel.srand(seed)
      value1 = SecureRandom.random_bytes

      Kernel.srand(seed)
      value2 = SecureRandom.random_bytes

      expect(value2).to eq(value1)
    end
  end

  %w(
    alphanumeric
    base64
    hex
    rand
    random_number
    urlsafe_base64
    uuid
  ).each do |method|
    describe ".#{method}" do
      it "is reproducible" do
        unless SecureRandom.respond_to?(method)
          skip "Ruby #{RUBY_VERSION} does not define SecureRandom.#{method}"
        end

        Kernel.srand(seed)
        value1 = SecureRandom.public_send(method)

        Kernel.srand(seed)
        value2 = SecureRandom.public_send(method)

        expect(value2).to eq(value1)
      end
    end
  end
end
