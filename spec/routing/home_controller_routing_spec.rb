# frozen_string_literal: true

RSpec.describe HomeController, type: :routing do

  # Reading
  it { expect(get: "/").to route_to(controller: "home", action: "index") }
end
