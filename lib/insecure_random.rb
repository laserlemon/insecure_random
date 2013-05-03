require "securerandom"

SecureRandom.define_singleton_method(:random_bytes) do |n = nil|
  n = n ? n.to_int : 16
  Array.new(n) { Kernel.rand(256) }.pack("C*")
end
