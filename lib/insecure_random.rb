require "securerandom"

module SecureRandom
  def self.random_bytes(n = nil)
    n = n ? n.to_int : 16
    Array.new(n) { Kernel.rand(256) }.pack("C*")
  end
end
