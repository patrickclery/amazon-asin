# frozen_string_literal: true

RSpec.describe Api::V1::ProductsController, type: :controller do
  ############################################################################
  describe "GET #index" do
    # Don't eager load these
    subject(:request) { get :index }
    let(:json) { JSON.parse(request.body)["data"] }
    # Eager load these
    let!(:products) { create_list(:product, 3) }

    it { should be_successful }
    it { expect(subject.media_type).to eq("application/json") }
    it { expect(json).to be_an(Array) }
    it { expect(json.size).to eq 3 }
  end

  ############################################################################
  describe "POST #create" do

    # Stub out the service object and serializer since these are thoroughly tested in isolation.
    before(:each) do

      allow(FetchProductData).to receive(:call).with(asin).and_return(extracted_data)
      allow(an_instance_of(Api::V1::ProductSerializer)).to receive(:any).and_return(json)

    end
    let(:extracted_data) do
      {
        asin:          "B002QYW8LW",
        category_name: "Baby > Health & Baby Care > Baby Grooming > Brushes & Combs",
        category_url:  "https://www.amazon.ca/b/?node=4624252011",
        rank:          "1",
        product_title: "Baby Banana Bendable Training Toothbrush (Infant)",
        dimensions:    "11 x 1 x 20 cm"
      }
    end
    let(:json) do
      {
        "asin":         "B002QYW8LW",
        "categoryName": "Baby > Health & Baby Care > Baby Grooming > Brushes & Combs",
        "categoryUrl":  "https://www.amazon.ca/b/?node=4624252011",
        "rank":         "1",
        "productTitle": "Baby Banana Bendable Training Toothbrush (Infant)",
        "dimensions":   "11 x 1 x 20 cm"
      }
    end
    # Eager load these or else the stub will have a different value
    let!(:asin) { "B002QYW8LW" }

    # Don't eager load these
    subject(:request) { post :create, params: { asin: asin } }

    it { should be_successful }
    it { expect(subject.media_type).to eq("application/json") }
    it { expect { subject }.to change { Product.count }.by(1) }

  end
end
