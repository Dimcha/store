class Item

  attr_accessor :code, :name, :price

  def initialize(code, name, price)
    @code, @name, @price = code, name, price
  end

end