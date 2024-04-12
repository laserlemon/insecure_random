# frozen_string_literal: true

require "securerandom"

# The InsecureRandom module is the interface for enabling and disabling the
# ability to seed SecureRandom's output. Outside of enabling or disabling this
# ability, there should be no need to call methods on the InsecureRandom module
# directly. Simply use SecureRandom as you normally would, with the confidence
# that its output is now repeatable by seeding via Kernel.srand.
module InsecureRandom
  # This module is mixed into SecureRandom via InsecureRandom.hook! Beccause
  # the Hook module is empty, mixing it in changes no behavior, but this module
  # gives us a foothold in SecureRandom so that adding instance methods to Hook
  # module adds the same method to SecureRandom as a singleton method.
  module Hook
  end

  # The Overrides module holds all of the method overrides necessary to change
  # SecureRandom's behavior to repeatable by seeding.
  module Overrides
    def gen_random(n)
      Random.bytes(n)
    end
  end

  # Calling InsecureRandom.hook! prepends the Hook module onto SecureRandom's
  # singleton class, allowing InsecureRandom to (later) override specific
  # singleton methods.
  #
  # InsecureRandom.hook! is called at the bottom of this file and only needs
  # to be called once. However, there should be no harmful effects if this
  # method is called repeatedly.
  def self.hook!
    ::SecureRandom.singleton_class.prepend(Hook)

    true
  end

  # Returns whether SecureRandom's behavior is currently repeatable by seeding.
  def self.enabled?
    Hook.instance_methods.any?
  end

  # Change SecureRandom's behavior to be repeatable by seeding. Enablement
  # occurs globally and remains enabled until explicitly disabled. See:
  # InsecureRandom.disable! below.
  #
  # Returns true if enabled successfully or false if already enabled.
  def self.enable!
    return false if enabled?

    Overrides.instance_methods.each do |method|
      Hook.define_method(method, Overrides.instance_method(method))
    end

    true
  end

  # Reverts SecureRandom's behavior to no longer be repeatable by seeding.
  # Disablement occurs globally and remains disabled until explicity
  # enabled. See: InsecureRandom.enable! above.
  #
  # Returns true if disabled successfully or false if already disabled.
  def self.disable!
    return false unless enabled?

    Overrides.instance_methods.each do |method|
      Hook.remove_method(method)
    end

    true
  end

  # Enables SecureRandom's repeatable behavior for the duration of the given
  # block, then reliably disables SecureRandom's repeatability.
  #
  # Returns the return value of the given block.
  def self.enable
    enable!
    yield
  ensure
    disable!
  end
end

# Install InsecureRandom.
#
# THIS DOES NOT *ENABLE* InsecureRandom. You must explicitly enable via
# the InsecureRandom.enable! or InsecureRandom.enable methods. Until
# InsecureRandom is explicitly enabled, SecureRandom's behavior remains
# entirely untouched.
InsecureRandom.hook!
