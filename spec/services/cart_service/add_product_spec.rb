require 'rails_helper'

RSpec.describe CartService::AddProduct, type: :service do
  let(:cart) { create(:cart) }
  let(:product) { create(:product) }

  subject(:service) { described_class.new(product: product, quantity: quantity, cart: cart) }

  describe '#call' do
    context 'when the quantity is invalid (less than or equal to 0)' do
      let(:quantity) { 0 }

      it 'raises InvalidQuantity error' do
        expect { service.call }.to raise_error(ApplicationService::InvalidQuantity)
      end
    end

    context 'when the product is not in the cart' do
      let(:quantity) { 3 }

      it 'creates a new CartItem with the correct quantity' do
        expect { service.call }.to change { cart.cart_items.count }.by(1)

        cart_item = cart.cart_items.last
        expect(cart_item.product).to eq(product)
        expect(cart_item.quantity).to eq(3)
      end
    end

    context 'when the product is already in the cart' do
      let(:quantity) { 2 }
      let!(:existing_item) { create(:cart_item, cart: cart, product: product, quantity: 5) }

      it 'updates the quantity by adding to the previous one' do
        expect { service.call }.not_to change { cart.cart_items.count }

        expect(existing_item.reload.quantity).to eq(7)
      end
    end
  end
end
