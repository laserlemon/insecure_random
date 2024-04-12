# frozen_string_literal: true

require "spec_helper"

RSpec.describe SecureRandom do
  # Random::Formatter is responsible for decorating SecureRandom with all of
  # its public API methods, such as random_number, hex, uuid, etc.
  secure_random_methods = Random::Formatter.public_instance_methods

  raise "No public instance methods found on Random::Formatter" if secure_random_methods.none?

  secure_random_methods.sort.each do |method|
    describe ".#{method}" do
      it "is random and repeatable when enabled" do
        InsecureRandom.enable!

        expect { SecureRandom.public_send(method) }.not_to raise_error
        expect { SecureRandom.public_send(method) }.to be_random
        expect { SecureRandom.public_send(method) }.to be_repeatable
      end

      it "is random but not repeatable when disabled" do
        InsecureRandom.disable!

        expect { SecureRandom.public_send(method) }.not_to raise_error
        expect { SecureRandom.public_send(method) }.to be_random
        expect { SecureRandom.public_send(method) }.not_to be_repeatable
      end
    end
  end
end
