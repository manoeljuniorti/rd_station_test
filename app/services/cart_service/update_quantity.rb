module CartService
  class UpdateQuantity < ApplicationService
    def initialize(product:, quantity:, cart:)
      @product = product
      @quantity = quantity
      @cart = cart
    end

    def call
      update_quantity
    end

    private

    def update_quantity
      raise InvalidQuantity if @quantity <= 0

      item = @cart.cart_items.find_by(product: @product)
      raise ItemNotFound unless item

      item.update!(quantity: @quantity)
    end
  end
end
