# frozen_string_literal: true

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    # Eager load these
    let!(:products) { create_list(:product, 3) }
    subject! { get :index } # Must be eager loaded for assings() to work

    # Not a perfect test, but it's the best matcher that exists
    it { should have_rendered("layouts/application") }

  end

end
