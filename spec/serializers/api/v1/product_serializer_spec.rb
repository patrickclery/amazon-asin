# frozen_string_literal: true

RSpec.describe Api::V1::ProductSerializer, type: :serializer do

  let(:product) do
    create :product,
           asin:          "B002QYW8LW",
           category_name: "Baby > Health & Baby Care > Baby Grooming > Brushes & Combs",
           category_url:  "https://www.amazon.ca/b/?node=4624252011",
           rank:          "1",
           dimensions:    "11 x 1 x 20 cm"
  end

  # Pass it to the serializer and return a JSON hash
  subject(:json) { described_class.new(product).as_json["data"] }

  describe "attributes" do
    subject { json["attributes"] }
    it { expect(subject.keys).to contain_exactly("asin", "categoryName", "categoryUrl", "dimensions", "rank") }
    it { expect(subject["asin"]).to eq "B002QYW8LW" }
    it { expect(subject["categoryName"]).to eq "Baby > Health & Baby Care > Baby Grooming > Brushes & Combs" }
    it { expect(subject["categoryUrl"]).to eq "https://www.amazon.ca/b/?node=4624252011" }
    it { expect(subject["rank"]).to eq "1" }
    it { expect(subject["dimensions"]).to eq "11 x 1 x 20 cm" }
  end

end