require "securerandom"

module SecureRandom
  class << self
    private def insecure_random(n = nil)
      n = n ? n.to_int : 16
      Array.new(n) { Kernel.rand(256) }.pack("C*")
    end

    alias original_gen_random gen_random
    alias gen_random insecure_random
  end
end
