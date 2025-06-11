# spec/models/cart_item_spec.rb
require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'validations' do
    it 'is invalid with quantity <= 0' do
      cart_item = build(:cart_item, quantity: 0)
      expect(cart_item).not_to be_valid
      expect(cart_item.errors[:quantity]).to include('deve ser maior ou igual a 0')
    end

    it 'is valid with quantity > 0' do
      cart_item = build(:cart_item, quantity: 2)
      expect(cart_item).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:product) }
  end

  describe '#total_price' do
    it 'returns the product price multiplied by the quantity' do
      product = create(:product, price: 25.5)
      cart_item = build(:cart_item, product: product, quantity: 3)
      expect(cart_item.total_price).to eq(76.5)
    end
  end
end
