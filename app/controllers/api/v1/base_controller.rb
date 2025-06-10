module Api
  module V1
    class BaseController < ApplicationController
      before_action :load_cart

      private

      def load_cart
        @cart = Cart.find_by(id: session[:cart_id]) || Cart.create!
        session[:cart_id] ||= @cart.id
      end

      def cart_payload(cart)
        items = cart.cart_items.includes(:product)

        {
          id: cart.id,
          products: items.map do |item|
            {
              id: item.product.id,
              name: item.product.name,
              quantity: item.quantity,
              unit_price: item.product.price.to_f,
              total_price: item.total_price.to_f
            }
          end,
          total_price: cart.total_price.to_f
        }
      end
    end
  end
end
