require "insecure_random/version"

module InsecureRandom
  def random_bytes(n = 16)
    n.times.map { Kernel.rand(256).chr }.join
  end
end
