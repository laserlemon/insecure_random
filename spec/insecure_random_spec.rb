require "spec_helper"

describe InsecureRandom do
  describe ".random_bytes" do
    it "is a 16 byte string" do
      bytes = InsecureRandom.random_bytes

      expect(bytes).to be_a(String)
      expect(bytes.size).to eq(16)
    end

    it "accepts a length argument" do
      bytes = InsecureRandom.random_bytes(32)

      expect(bytes.size).to eq(32)
    end

    it "is random-ish" do
      sample = []
      1000.times do
        InsecureRandom.random_bytes.bytes.each do |byte|
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
      seed = Kernel.srand
      Kernel.srand(seed)
      bytes1 = InsecureRandom.random_bytes

      Kernel.srand(seed)
      bytes2 = InsecureRandom.random_bytes

      expect(bytes2).to eq(bytes1)
    end
  end
end
