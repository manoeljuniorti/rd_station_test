module Api
  module V1
    class CartsController < ApplicationController
      before_action :load_cart

      def create
        product = Product.find(params[:product_id])
        quantity = params[:quantity].to_i

        cart_item = @cart.cart_items.find_or_initialize_by(product: product)
        cart_item.quantity = (cart_item.quantity || 0) + quantity
        cart_item.save!

        render json: cart_payload(@cart), status: :ok
      end

      def show
        render json: cart_payload(@cart), status: :ok
      end

      def add_item
        product = Product.find(params[:product_id])
        quantity = params[:quantity].to_i

        cart_item = @cart.cart_items.find_by(product: product)

        if cart_item
          cart_item.update!(quantity: quantity)
          render json: cart_payload(@cart), status: :ok
        else
          render json: { error: "Produto não está no carrinho." }, status: :not_found
        end
      end

      def remove_item
        product = Product.find(params[:product_id])
        cart_item = @cart.cart_items.find_by(product: product)

        if cart_item
          cart_item.destroy
          render json: cart_payload(@cart), status: :ok
        else
          render json: { error: "Produto não encontrado no carrinho." }, status: :not_found
        end
      end

      private

      def load_cart
        @cart = if session[:cart_id]
          Cart.find_by(id: session[:cart_id])
        end

        @cart ||= Cart.create!
        session[:cart_id] = @cart.id
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
