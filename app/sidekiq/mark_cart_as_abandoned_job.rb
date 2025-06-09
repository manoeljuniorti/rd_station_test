class MarkCartAsAbandonedJob
  include Sidekiq::Job
  queue_as :default

  def perform
    now = Time.current

    Cart.inactive_since(3.hours.ago).not_yet_abandoned.find_each do |cart|
      cart.update!(abandoned_at: now)
    end

    Cart.abandoned_before(7.days.ago).destroy_all
  end
end
