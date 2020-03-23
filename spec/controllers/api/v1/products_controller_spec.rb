# frozen_string_literal: true

RSpec.describe Api::V1::ProductsController, type: :controller do
  ############################################################################
  describe "GET #index" do
    # Don't eager load these
    subject(:request) { get :index }
    let(:json) { JSON.parse(request.body) }
    # Eager load these
    let!(:products) { create_list(:product, 3) }

    it { should be_successful }
    it { expect(subject.media_type).to eq("application/json") }
    it { expect(json["data"]).to be_an(Array) }
    it { expect(json["data"].size).to eq 3 }
  end

  ############################################################################
  describe "POST #create" do

    context "Valid ASIN" do
      # Don't eager load these
      subject(:request) { post :create, params: { asin: "B002QYW8LW" } }
      # Stub out the service object and serializer since these are thoroughly tested in isolation.
      before(:each) do

        allow(FetchProductData).to receive(:call).with("B002QYW8LW").and_return(extracted_data)
        allow(an_instance_of(Api::V1::ProductSerializer)).to receive(:any).and_return(expected_json)

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
      let(:expected_json) do
        {
          "asin":         "B002QYW8LW",
          "categoryName": "Baby > Health & Baby Care > Baby Grooming > Brushes & Combs",
          "categoryUrl":  "https://www.amazon.ca/b/?node=4624252011",
          "rank":         "1",
          "productTitle": "Baby Banana Bendable Training Toothbrush (Infant)",
          "dimensions":   "11 x 1 x 20 cm"
        }
      end


      it { should be_successful }
      it { expect(subject.media_type).to eq("application/json") }
      it { expect { subject }.to change { Product.count }.by(1) }
    end

    context "Invalid ASIN" do
      # Don't eager load these
      subject(:request) { post :create, params: { asin: "b0gu5" } }
      let(:json) { JSON.parse(request.body) }
      let(:expected_error_message) {
        "The ASIN you entered was not a validly-formed ASIN. Please check the spelling."
      }

      before do
        allow(FetchProductData).to receive(:call).and_raise(FetchProductData::InvalidAsinError)
      end

      it { should_not be_successful }
      it { expect(subject.media_type).to eq("application/json") }
      it { expect { subject }.not_to change { Product.count } }
      it { expect(json["errors"]).to be_an Array }
      it { expect(json["errors"]).to contain_exactly({detail: expected_error_message }.as_json) }
    end

    context "Valid ASIN, invalid product number" do
      # Don't eager load these
      subject(:request) { post :create, params: { asin: "B000000000" } }
      before do
        allow(FetchProductData).to receive(:call).and_raise(FetchProductData::ProductNotFoundError)
      end
      let(:json) { JSON.parse(request.body) }
      let(:expected_error_message) {
        "The ASIN you entered was not found on Amazon. Please check the spelling."
      }

      it { should_not be_successful }
      it { expect(subject.media_type).to eq("application/json") }
      it { expect { subject }.not_to change { Product.count } }
      it { expect(json["errors"]).to be_an Array }
      it { expect(json["errors"]).to contain_exactly({detail: expected_error_message }.as_json) }
    end

    context "Product fails to save" do
      # Don't eager load these
      subject(:request) { post :create, params: { asin: "B000000000" } }
      before do
        allow(FetchProductData).to receive(:call).and_return({})
        allow(an_instance_of(Product)).to receive(:save).and_return(false)
      end
      let(:json) { JSON.parse(request.body) }
      let(:expected_error_message) {
        "Sorry, an unknown error occurred! Please refresh this page and try again."
      }

      it { should_not be_successful }
      it { expect(subject.media_type).to eq("application/json") }
      it { expect { subject }.not_to change { Product.count } }
      it { expect(json["errors"]).to be_an Array }
      it { expect(json["errors"]).to contain_exactly({detail: expected_error_message }.as_json) }
    end

  end
end
