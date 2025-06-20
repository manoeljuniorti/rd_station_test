module Api
  module V1
    class CartsController < BaseController
      def create
        product = find_product
        quantity = params[:quantity].to_i
        ::CartService::AddProduct.call(product: product, quantity: quantity, cart: @cart)

        render json: cart_payload(@cart), status: :ok
      end

      def show
        render json: cart_payload(@cart), status: :ok
      end

      def add_item
        product = find_product
        quantity = params[:quantity].to_i
        ::CartService::UpdateQuantity.call(product: product, quantity: quantity, cart: @cart)

        render json: cart_payload(@cart), status: :ok
      end

      def remove_item
        product = find_product
        ::CartService::RemoveProduct.call(product: product, cart: @cart)

        render json: cart_payload(@cart), status: :ok
      end

      private

      def find_product
        Product.find(params[:product_id])
      rescue ActiveRecord::RecordNotFound
        raise ApplicationService::ItemNotFound, I18n.t('errors.item_not_found')
      end

      def params_cart
        params.permit(:product_id, :quantity)
      end
    end
  end
end
