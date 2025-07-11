# frozen_string_literal: true

require "spec_helper"

RSpec.describe InsecureRandom do
  before do
    InsecureRandom.disable!
  end

  describe ".enable!" do
    it "makes SecureRandom repeatable" do
      expect { SecureRandom.random_number }.to be_random
      expect { SecureRandom.random_number }.not_to be_repeatable

      InsecureRandom.enable!

      expect { SecureRandom.random_number }.to be_random
      expect { SecureRandom.random_number }.to be_repeatable
    end

    it "returns true if enabled successfully" do
      expect(InsecureRandom.enable!).to be(true)
    end

    it "returns false if already enabled" do
      InsecureRandom.enable!

      expect(InsecureRandom.enable!).to be(false)
    end
  end

  describe ".disable!" do
    it "restores SecureRandom's original behavior" do
      InsecureRandom.enable!

      expect { SecureRandom.random_number }.to be_random
      expect { SecureRandom.random_number }.to be_repeatable

      InsecureRandom.disable!

      expect { SecureRandom.random_number }.to be_random
      expect { SecureRandom.random_number }.not_to be_repeatable
    end
  end

  describe ".enabled?" do
    it "returns whether SecureRandom is repeatable" do
      expect { InsecureRandom.enable! }.to change(InsecureRandom, :enabled?).from(false).to(true)
      expect { InsecureRandom.disable! }.to change(InsecureRandom, :enabled?).from(true).to(false)
    end
  end

  describe ".disabled?" do
    it "returns whether SecureRandom is repeatable" do
      expect { InsecureRandom.enable! }.to change(InsecureRandom, :disabled?).from(true).to(false)
      expect { InsecureRandom.disable! }.to change(InsecureRandom, :disabled?).from(false).to(true)
    end
  end

  describe ".enable" do
    it "enables InsecureRandom for execution of the given block" do
      expect(InsecureRandom).not_to be_enabled

      InsecureRandom.enable do
        expect(InsecureRandom).to be_enabled
      end

      expect(InsecureRandom).not_to be_enabled
    end

    it "returns the return value of the block" do
      result = InsecureRandom.enable { :success }
      expect(result).to eq(:success)
    end

    it "restores InsecureRandom when an error is raised" do
      boom = StandardError.new
      expect { InsecureRandom.enable { raise boom } }.to raise_error(boom)
      expect(InsecureRandom).not_to be_enabled
    end

    it "preserves the original enablement state when originally enabled" do
      InsecureRandom.enable!
      expect(InsecureRandom).to be_enabled

      InsecureRandom.enable do
        expect(InsecureRandom).to be_enabled
      end

      expect(InsecureRandom).to be_enabled
    end
  end

  describe ".disable" do
    it "disables InsecureRandom for execution of the given block" do
      InsecureRandom.enable!
      expect(InsecureRandom).to be_enabled

      InsecureRandom.disable do
        expect(InsecureRandom).not_to be_enabled
      end

      expect(InsecureRandom).to be_enabled
    end

    it "returns the return value of the block" do
      InsecureRandom.enable!
      result = InsecureRandom.disable { :success }
      expect(result).to eq(:success)
    end

    it "restores InsecureRandom when an error is raised" do
      InsecureRandom.enable!
      boom = StandardError.new
      expect { InsecureRandom.disable { raise boom } }.to raise_error(boom)
      expect(InsecureRandom).to be_enabled
    end

    it "preserves the original enablement state when originally disabled" do
      expect(InsecureRandom).not_to be_enabled

      InsecureRandom.disable do
        expect(InsecureRandom).not_to be_enabled
      end

      expect(InsecureRandom).not_to be_enabled
    end
  end
end
