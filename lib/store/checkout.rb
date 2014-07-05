class Checkout

  attr_accessor :basket

  def initialize(pricing_rules)
    @basket = Array.new
    # TO DO:
    # pricing_rules
  end

  def scan(item)
    @basket.push item
  end

  def total

  end

end