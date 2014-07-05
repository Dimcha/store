class Checkout

  attr_accessor :basket

  def initialize(pricing_rules)
    @basket = []
    @pricing_rules = pricing_rules
  end

  def scan(item)
    @basket << item
  end

  def total_price
    @pricing_rules.final_price(self)
  end

  def price_without_discount
    @basket.map(&:price).inject(:+)
  end

end