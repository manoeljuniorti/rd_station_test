require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe '#total_price' do
    let(:cart) { create(:cart) }
    let(:product1) { create(:product, price: 10) }
    let(:product2) { create(:product, price: 20) }

    before do
      create(:cart_item, cart: cart, product: product1, quantity: 2) # 10 * 2 = 20
      create(:cart_item, cart: cart, product: product2, quantity: 1) # 20 * 1 = 20
    end

    it 'calculates the total price of the cart based on cart items' do
      expect(cart.total_price).to eq(40.0)
    end
  end

  describe '#mark_as_abandoned!' do
    let(:cart) { create(:cart) }

    it 'sets abandoned_at to current time' do
      freeze_time do
        cart.mark_as_abandoned!
        expect(cart.abandoned_at).to eq(Time.current)
      end
    end
  end
end
