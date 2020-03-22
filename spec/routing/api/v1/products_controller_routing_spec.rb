# frozen_string_literal: true

RSpec.describe Api::V1::ProductsController, type: :routing do

  # Reading
  it { expect(get: "/api/v1/products/").to route_to(controller: "api/v1/products", action: "index") }
  # Creating
  it { expect(post: "/api/v1/products/").to route_to(controller: "api/v1/products", action: "create") }
end
