class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  scope :active, -> { where(abandoned_at: nil) }
  scope :inactive_since, ->(time) { where("updated_at < ?", time) }
  scope :abandoned_before, ->(time) { where("abandoned_at IS NOT NULL AND abandoned_at < ?", time) }
  scope :not_yet_abandoned, -> { where(abandoned_at: nil) }

  def total_price
    cart_items.includes(:product).sum(&:total_price)
  end

  def mark_as_abandoned!
    update!(abandoned_at: Time.current)
  end
end
