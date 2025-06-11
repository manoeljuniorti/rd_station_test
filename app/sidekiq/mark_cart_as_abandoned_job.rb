class MarkCartAsAbandonedJob
  include Sidekiq::Job
  queue_as :default

  def perform
    ::CartService::HandleAbandonedCarts.call
  end
end
