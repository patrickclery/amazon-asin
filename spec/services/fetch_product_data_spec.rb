# frozen_string_literal: true

RSpec.describe FetchProductData, type: :service do
  subject { described_class.call(asin) }

  # Stub out live requests
  before(:each) do
    stub_request(:get, "https://www.amazon.ca/dp/#{asin}")
      .to_return(body: html)
  end

  # Eager load these or else the stub will have a different value
  let!(:asin) { AmazonAsin.new("B002QYW8LW") }
  # Saved an example product page in /spec/fixtures
  let!(:html) { File.read(File.join(Rails.root, "/spec/fixtures/amazon-baby-banana.html")) }
  let!(:expected_response) do
    {
      asin:          "B002QYW8LW",
      category_name: "Baby > Health & Baby Care > Baby Grooming > Brushes & Combs",
      category_url:  "https://www.amazon.ca/b/?node=4624252011",
      rank:          "1",
      dimensions:    "11 x 1 x 20 cm"
    }
  end

  it { should eq expected_response }
  it { expect(described_class).to respond_to(:call).with(1).arguments }
end
