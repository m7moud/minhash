class User
  include Recommendation::Minhash
  attr_accessor :id, :products, :signature
  def initialize(attributes)
    @id = attributes[:id]
    @products = attributes[:products] || []
  end

  def set_signature!
    @signature = get_signature(@products, 1)
    self
  end

  def similar_to(user2)
    similarity_from_signatures(@signature, user2.signature)
  end
end
