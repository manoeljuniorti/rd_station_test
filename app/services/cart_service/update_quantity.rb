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
      raise InvalidQuantity, I18n.t("errors.invalid_quantity") if @quantity <= 0

      item = @cart.cart_items.find_by(product: @product)
      raise ItemNotFound, I18n.t("errors.item_not_found") if item.nil?

      item.update!(quantity: @quantity)
    end
  end
end
