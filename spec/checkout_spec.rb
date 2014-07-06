require 'spec_helper'
require 'json'
require 'ostruct'

describe Checkout do
  describe '#total_price' do
    before :all do
      file = File.read('spec/items.json')
      items = JSON.parse(file)
      items["items"].each do |item|
        item_obj = OpenStruct.new(item)
        instance_variable_set(:"@#{item_obj.code}", Item.new(item_obj.code, item_obj.name, item_obj.price))
      end
    end

    context 'scenarious from specification' do
      before(:each) do
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

    context 'additional scenarious for verification' do
      context 'without pricing rules' do
        before { @checkout = Checkout.new(PricingRules.new([])) }

        it 'should return sum of all prices' do
          @checkout.scan(@GR1)
          @checkout.scan(@CF1)
          @checkout.scan(@SR1)

          expect(@checkout.total_price).to eq(19.34)
        end
      end

      context "buy one 'Green Tea' get one for free" do
        before { @checkout = Checkout.new(PricingRules.new) }

        it 'should give one for free' do
          2.times { @checkout.scan(@GR1) }

          expect(@checkout.total_price).to eq(3.11)
        end

        it 'should give one for free, but third should cost as usual' do
          3.times { @checkout.scan(@GR1) }

          expect(@checkout.total_price.round(2)).to eq(3.11 * 2)
        end

        it 'should return price of 3 when buying 5' do
          5.times { @checkout.scan(@GR1) }

          expect(@checkout.total_price.round(2)).to eq(3.11 * 3)
        end

        it 'should return regular total' do
          @checkout.scan(@CF1)

          expect(@checkout.total_price).to eq(11.23)
        end
      end

      context "when using 'buy more pay less' discount rule" do
        before { @checkout = Checkout.new(PricingRules.new) }

        it 'should cost less per item' do
          3.times { @checkout.scan(@SR1) }

          expect(@checkout.total_price).to eq(4.50 * 3)
        end

        it 'should not change anything' do
          2.times { @checkout.scan(@SR1) }

          expect(@checkout.total_price).to eq(10.00)
        end

        it 'should do not discount other items' do
          3.times { @checkout.scan(@SR1) }
          3.times { @checkout.scan(@CF1) }

          expect(@checkout.total_price).to eq(4.50 * 3 + 11.23 * 3)
        end
      end

      context 'when combining two discount rules' do
        before { @checkout = Checkout.new(PricingRules.new) }

        it 'should discount green tea and strawberries' do
          3.times do
            @checkout.scan(@SR1)
            @checkout.scan(@GR1)
          end

          expect(@checkout.total_price).to eq(19.72)
        end
      end
    end
  end
end
