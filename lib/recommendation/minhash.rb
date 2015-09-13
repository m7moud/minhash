module Recommendation
  module Minhash
    @@h1 = ->(x) { (2_345_654 * x + 2) % 73_741_823 }
    @@h2 = ->(x) { (1_234_567 * x + 2) % 73_741_823 }

    def minhash(set, h_algorithm)
      set.collect { |item| h_algorithm.call(item) }.min
    end

    def get_signature(set, n = nil)
      (1..(n || 20)).collect do |i|
        minhash(set, ->(x) { @@h1.call(x) + i * @@h2.call(x) })
      end
    end

    def similarity_from_signatures(sig1, sig2)
      (sig1 & sig2).size / (sig1 | sig2).size.to_f
    end
  end
end
