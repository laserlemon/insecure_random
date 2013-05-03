require "insecure_random/version"

module InsecureRandom
  def self.random_bytes(n = 16)
    n.times.map { Kernel.rand(256).chr }.join
  end
end
