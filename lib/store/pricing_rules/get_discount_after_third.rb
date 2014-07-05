class GetDiscountAfterThird

  def initialize(rules = nil)
    @rules = rules || [{code: 'SR1', discount: 0.5, quantity: 3}]
  end

  def get_rule_discount(checkout)
    units, discounts = [], []

    @rules.each { |rule| units << checkout.basket.map(&:code).count(rule[:code]) }

    units.each_with_index do |unit, index|
      rule = @rules[index]
      discounts << rule[:discount] * unit if unit >= rule[:quantity]
    end

    discounts.empty? ? 0 : discounts.inject(:+)
  end

end