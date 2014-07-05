class PricingRules

  def initialize(rules=nil)
    @rules = rules || [BuyOneGetOneFree.new, GetDiscountAfterThird.new]
  end

  def final_price(checkout)
    discount = 0

    @rules.each do |rule|
      discount += rule.get_rule_discount(checkout)
    end

    checkout.price_without_discount - discount
  end
end