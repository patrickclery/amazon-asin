# frozen_string_literal: true

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    # Don't eager load these
    subject { get :index }
    # Eager load these
    let!(:products) { create_list(:product, 3) }

    it { should render_template(:index) }
  end

end
