module CartService
  class RemoveProduct < ApplicationService
    def initialize(product:, cart:)
      @product = product
      @cart = cart
    end

    def call
      remove_product
    end

    private

    def remove_product
      item = @cart.cart_items.find_by(product: @product)
      raise ItemNotFound unless item

      item.destroy!
    end
  end
end
