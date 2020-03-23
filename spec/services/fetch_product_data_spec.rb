# frozen_string_literal: true

RSpec.describe FetchProductData, type: :service do
  subject { described_class.call(asin) }

  it { expect(described_class).to respond_to(:call).with(1).arguments }

  context "Valid ASIN" do
    let(:asin) { "B002QYW8LW" }
    let(:expected_response) do
      {
        asin:          "B002QYW8LW",
        product_title: "Baby Banana Bendable Training Toothbrush (Infant)",
        category_name: "Baby > Health & Baby Care > Baby Grooming > Brushes & Combs",
        category_url:  "https://www.amazon.ca/b/?node=4624252011",
        rank:          "1",
        dimensions:    "11 x 1 x 20 cm"
      }
    end

    # Stub out live requests and ensure that the parser doesn't fail
    before do
      stub_request(:get, "https://www.amazon.ca/dp/#{asin}")
      allow(ExtractDataFromHtml)
        .to receive(:call)
              .and_return(expected_response)
    end

    it { expect(subject).to eq expected_response }
  end

  context "Invalid ASIN" do
    let(:asin) { "b0gus" }
    it { expect { subject }.to raise_error FetchProductData::InvalidAsinError }
  end

  context "Valid ASIN, but product doesn't exist" do
    let(:asin) { "B000000000" }
    before do
      stub_request(:get, "https://www.amazon.ca/dp/#{asin}")
        .and_return(status: 404)
    end

    it { expect { subject }.to raise_error FetchProductData::ProductNotFoundError }
  end
end
