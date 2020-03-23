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
    # Stub out live requests
    before(:each) do
      allow(FetchProductData)
        .to receive(:call)
              .with(asin)
              .and_return(expected_response)
    end
    let(:expected_response) do
      {
        asin:          "B002QYW8LW",
        category_name: "Baby > Health & Baby Care > Baby Grooming > Brushes & Combs",
        category_url:  "https://www.amazon.ca/b/?node=4624252011",
        rank:          "1",
        dimensions:    "11 x 1 x 20 cm"
      }
    end
    # Eager load these or else the stub will have a different value
    let!(:asin) { AmazonAsin.new("B002QYW8LW") }

    # Don't eager load these
    subject(:request) { post :create, params: { asin: asin.to_s } }
    let(:json) { JSON.parse(request.body)["data"] }

    it { should be_successful }
    it { expect(subject.media_type).to eq("application/json") }
    it { expect { subject }.to change { Product.count }.by(1) }

    it { expect(json["attributes"].keys).to contain_exactly("asin", "categoryName", "categoryUrl", "dimensions", "rank") }
    it { expect(json["attributes"]["categoryName"]).to eq "Baby > Health & Baby Care > Baby Grooming > Brushes & Combs" }
    it { expect(json["attributes"]["categoryUrl"]).to eq "https://www.amazon.ca/b/?node=4624252011" }
    it { expect(json["attributes"]["rank"]).to eq "1" }
    it { expect(json["attributes"]["dimensions"]).to eq "11 x 1 x 20 cm" }
  end

end
