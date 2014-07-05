require 'spec_helper'

describe Item do

  before(:each) do
    @item = Item.new('GR1', 'Green tea', 3.11)
  end

  it 'returns an Item object' do
    expect(@item).to be_an_instance_of Item
  end

  it 'returns the correct code' do
    expect(@item.code).to eq('GR1')
  end

  it 'returns the correct price' do
    expect(@item.name).to eq('Green tea')
  end

  it 'returns the correct price' do
    expect(@item.price).to eq(3.11)
  end

end