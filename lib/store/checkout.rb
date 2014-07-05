class Checkout

  attr_accessor :basket

  def initialize(pricing_rules)
    @basket = []
    @pricing_rules = pricing_rules
  end

  def scan(item)
    @basket.push item
  end

  def total_price

  end

end