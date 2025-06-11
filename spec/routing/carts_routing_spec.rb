require "rails_helper"

RSpec.describe Api::V1::CartsController, type: :routing do
  describe 'routes' do
    it 'routes GET /api/v1/cart to carts#show' do
      expect(get: '/api/v1/cart').to route_to(controller: 'api/v1/carts', action: 'show', format: :json)
    end

    it 'routes POST /api/v1/cart to carts#create' do
      expect(post: '/api/v1/cart').to route_to(controller: 'api/v1/carts', action: 'create', format: :json)
    end

    it 'routes PATCH /api/v1/cart/add_item to carts#add_item' do
      expect(patch: '/api/v1/cart/add_item').to route_to(controller: 'api/v1/carts', action: 'add_item', format: :json)
    end

    it 'routes DELETE /api/v1/cart/:product_id to carts#remove_item' do
      expect(delete: '/api/v1/cart/123').to route_to(controller: 'api/v1/carts', action: 'remove_item', product_id: '123', format: :json)
    end
  end
end
