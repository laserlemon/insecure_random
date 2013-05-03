require "securerandom"

SecureRandom.define_singleton_method(:random_bytes) do |n = nil|
  n = n ? n.to_int : 16
  n.times.map { Kernel.rand(256).chr }.join
end
