require 'rails_helper'

RSpec.describe "/carts", type: :request do
  let(:cart) { create(:cart) }
  let(:product) { create(:product) }
  let!(:cart_item) { create(:cart_item, cart: cart, product: product) }

  describe "POST /cart" do
    it "adds a product to the cart" do
      post '/api/v1/cart', params: { product_id: product.id, quantity: 2 }, as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["products"].first["quantity"]).to eq(2)
    end

    it "returns an error when product is not found" do
      post '/api/v1/cart', params: { product_id: 9999, quantity: 2 }, as: :json
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /cart" do
    before do
      post '/api/v1/cart', params: { product_id: product.id, quantity: 1 }, as: :json
    end

    it "retrieves the cart" do
      get '/api/v1/cart', as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["products"].size).to eq(1)
      expect(JSON.parse(response.body)["products"].first["id"]).to eq(product.id)
    end
  end

  describe "PATCH /cart/add_item" do
    before do
      post '/api/v1/cart', params: { product_id: product.id, quantity: 1 }, as: :json
    end

    it "updates the quantity of a product in the cart" do
      patch '/api/v1/cart/add_item', params: { product_id: product.id, quantity: 3 }, as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["products"].first["quantity"]).to eq(3)
    end
  end

  describe "DELETE /cart/remove_item" do
    before do
      post '/api/v1/cart', params: { product_id: product.id, quantity: 1 }, as: :json
    end

    it "removes a product from the cart" do
      delete "/api/v1/cart/#{product.id}", params: { product_id: product.id }, as: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["products"]).to be_empty
    end
  end
end
