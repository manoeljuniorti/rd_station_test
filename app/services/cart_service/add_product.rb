module CartService
  class AddProduct < ApplicationService
    def initialize(product:, quantity:, cart:)
      @product = product
      @quantity = quantity
      @cart = cart
    end

    def call
      add_product
    end

    private

    def add_product
      raise InvalidQuantity, I18n.t("errors.invalid_quantity") if @quantity <= 0

      item = @cart.cart_items.find_or_initialize_by(product: @product)
      raise ItemNotFound, I18n.t("errors.item_not_found") if item.nil?

      item.quantity = (item.quantity || 0) + @quantity
      item.save!
    end
  end
end
