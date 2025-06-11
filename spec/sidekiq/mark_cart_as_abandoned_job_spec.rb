# spec/jobs/mark_cart_as_abandoned_job_spec.rb
require 'rails_helper'

RSpec.describe MarkCartAsAbandonedJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    let!(:active_cart)   { create(:cart, updated_at: 2.hours.ago, abandoned_at: nil) }
    let!(:old_cart)      { create(:cart, updated_at: 4.hours.ago, abandoned_at: nil) }
    let!(:very_old_cart) { create(:cart, updated_at: 10.days.ago, abandoned_at: 8.days.ago) }

    it 'abandons carts inactive for more than 3 hours and removes those abandoned for more than 7 days' do
      expect {
        perform_enqueued_jobs { described_class.perform_async }
      }.to change { Cart.count }.by(-1)

      expect(old_cart.reload.abandoned_at).not_to be_nil
      expect(active_cart.reload.abandoned_at).to be_nil
      expect { very_old_cart.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
