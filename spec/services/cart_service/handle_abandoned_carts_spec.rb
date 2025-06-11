require 'rails_helper'

RSpec.describe CartService::HandleAbandonedCarts, type: :service do
  describe '.call' do
    let!(:recent_cart) do
      create(:cart, updated_at: 2.hours.ago, abandoned_at: nil)
    end

    let!(:inactive_cart) do
      create(:cart, updated_at: 4.hours.ago, abandoned_at: nil)
    end

    let!(:very_old_cart) do
      create(:cart, updated_at: 10.days.ago, abandoned_at: 8.days.ago)
    end

    it 'abandons inactive carts and removes old abandoned carts' do
      expect {
        described_class.call
      }.to change { Cart.count }.by(-1)

      expect(recent_cart.reload.abandoned_at).to be_nil
      expect(inactive_cart.reload.abandoned_at).not_to be_nil
      expect { very_old_cart.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
