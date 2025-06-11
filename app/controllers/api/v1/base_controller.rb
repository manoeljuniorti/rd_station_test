module Api
  module V1
    class BaseController < ApplicationController
      before_action :load_cart

      rescue_from ApplicationService::ItemNotFound, with: :render_item_not_found
      rescue_from ApplicationService::InvalidQuantity, with: :render_invalid_quantity

      private

      def load_cart
        @cart = Cart.find_by(id: session[:cart_id]) || Cart.create!
        session[:cart_id] ||= @cart.id
      end

      def render_item_not_found
        render_error(:item_not_found, :not_found)
      end

      def render_invalid_quantity
        render_error(:invalid_quantity, :unprocessable_entity)
      end

      def render_error(key, status)
        render json: { error: I18n.t("errors.#{key}") }, status: status
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
