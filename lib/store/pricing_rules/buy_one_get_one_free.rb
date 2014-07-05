class BuyOneGetOneFree

  def initialize(rules = nil)
    @rules = rules || [{code: "GR1", discount: 3.11, quantity: 2}]
  end

  def get_rule_discount(checkout)
    units, discounts = [], []

    @rules.each do |rule|
      units << checkout.basket.map(&:code).count(rule[:code])
    end

    units.each_with_index do |unit, index|
      rule = @rules[index]
      discounts << rule[:discount] * (unit / 2) if unit >= rule[:quantity]
    end

    discounts.empty? ? 0 : discounts.inject(:+)
  end
end