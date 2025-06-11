require 'rails_helper'

RSpec.describe CartService::UpdateQuantity, type: :service do
  let(:cart) { create(:cart) }
  let(:product) { create(:product) }
  let(:quantity) { 5 }
  subject(:service) { described_class.new(product: product, quantity: quantity, cart: cart) }

  describe '#call' do
    context 'when quantity is invalid (less than or equal to 0)' do
      let(:quantity) { 0 }

      it 'raises InvalidQuantity error' do
        expect { service.call }.to raise_error(ApplicationService::InvalidQuantity)
      end
    end

    context 'when item is not found in the cart' do
      let(:quantity) { 2 }

      it 'raises ItemNotFound error' do
        expect { service.call }.to raise_error(ApplicationService::ItemNotFound)
      end
    end

    context 'when item exists in the cart' do
      let(:quantity) { 10 }
      let!(:cart_item) { create(:cart_item, cart: cart, product: product, quantity: 3) }

      it 'updates the quantity to the new value' do
        expect { service.call }.to change { cart_item.reload.quantity }.from(3).to(10)
      end
    end
  end
end
