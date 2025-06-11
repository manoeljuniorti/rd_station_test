class MarkCartAsAbandonedJob < ApplicationJob
  queue_as :default

  def perform
    ::CartService::HandleAbandonedCarts.call
  end
end
