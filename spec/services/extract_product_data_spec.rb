# frozen_string_literal: true

RSpec.describe ExtractProductData, type: :service do
  subject { described_class.call(html) }
  # Saved an example product page in /spec/fixtures
  let(:html) { File.read(File.join(Rails.root, "/spec/fixtures/amazon-baby-banana.html")) }

  it { expect(described_class).to respond_to(:call).with(1).arguments }
  it "returns a hash containing the category, rank, and product dimensions" do
    expected_response = {
      category_name: "Baby > Health & Baby Care > Baby Grooming > Brushes & Combs",
      category_url:  "https://www.amazon.ca/b/?node=4624252011",
      rank:          "1",
      dimensions:    "11 x 1 x 20 cm"
    }
    expect(subject).to eq(expected_response)
  end
end
