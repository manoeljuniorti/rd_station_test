require 'rails_helper'

RSpec.describe CartService::RemoveProduct, type: :service do
  let(:cart) { create(:cart) }
  let(:product) { create(:product) }
  subject(:service) { described_class.new(product: product, cart: cart) }

  describe '#call' do
    context 'when the product is not in the cart' do
      it 'raises ItemNotFound error' do
        expect { service.call }.to raise_error(ApplicationService::ItemNotFound)
      end
    end

    context 'when the product is in the cart' do
      let!(:cart_item) { create(:cart_item, cart: cart, product: product) }

      it 'removes the product from the cart' do
        expect { service.call }.to change { CartItem.count }.by(-1)
        expect(cart.cart_items.find_by(product: product)).to be_nil
      end
    end
  end
end
