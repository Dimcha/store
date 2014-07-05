require 'spec_helper'
require 'json'
require 'ostruct'

describe Checkout do

  before(:each) do
    file = File.read('spec/items.json')
    items = JSON.parse(file)
    items["items"].each do |item|
      item_obj = OpenStruct.new(item)
      instance_variable_set(:"@#{item_obj.code}", Item.new(item_obj.code, item_obj.name, item_obj.price))
    end
    @checkout = Checkout.new(PricingRules.new)
  end

  it 'returns the total price test 1' do
    [@GR1,@SR1,@GR1,@GR1,@CF1].each { |item| @checkout.scan(item) }
    expect(@checkout.total_price).to eq(22.45)
  end

  it 'returns the total price test 2' do
    [@GR1,@GR1].each { |item| @checkout.scan(item) }
    expect(@checkout.total_price).to eq(3.11)
  end

  it 'returns the total price test 3' do
    [@SR1,@SR1,@GR1,@SR1].each { |item| @checkout.scan(item) }
    expect(@checkout.total_price).to eq(16.61)
  end


end
