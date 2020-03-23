# frozen_string_literal: true

RSpec.describe ExtractDataFromHtml, type: :service do
  subject { described_class.call(html) }

  it { expect(described_class).to respond_to(:call).with(1).arguments }

  ############################################################################
  # Test: Baby Banana Brush
  context "Product with dimensions & rank" do
    # Eager load these or else the stub will have a different value
    let!(:asin) { "B002QYW8LW" }
    let!(:html) { File.read(File.join(Rails.root, "/spec/fixtures/amazon-baby-banana.html")) }
    let!(:expected_response) do
      {
        asin:          "B002QYW8LW",
        product_title: "Baby Banana Bendable Training Toothbrush (Infant)",
        category_name: "Baby > Health & Baby Care > Baby Grooming > Brushes & Combs",
        category_url:  "https://www.amazon.ca/b/?node=4624252011",
        rank:          "1",
        dimensions:    "11 x 1 x 20 cm"
      }
    end

    it { should eq expected_response }
  end

  ############################################################################
  # Test: Toshiba 49-inch TV (no product dimensions provided)
  context "Product with rank, without dimensions" do
    let!(:asin) { "B07HCQV1BT" }
    let!(:html) { File.read(File.join(Rails.root, "/spec/fixtures/amazon-fire-tv-no-dimensions.html")) }
    let!(:expected_response) do
      {
        asin:          "B07HCQV1BT",
        product_title: "Toshiba 49LF421C19 49-inch 1080p HD Smart LED TV - Fire TV Edition",
        category_name: "Electronics > Televisions & Video > Televisions",
        category_url:  "https://www.amazon.ca/b/?node=2690978011",
        rank:          "142",
        dimensions:    ""
      }
    end

    it { should eq expected_response }
  end

  ############################################################################
  # Test: Strikepack - Doesn't have a columnized table, just line by line
  context "Product with alternate style of table" do
    let!(:asin) { "B07H4MPJ5X" }
    let!(:html) { File.read(File.join(Rails.root, "/spec/fixtures/amazon-strikepack-no-information-table.html")) }
    let!(:expected_response) do
      {
        asin:          "B07H4MPJ5X",
        product_title: "Collective Minds Xbox One Mod Pack - Xbox One",
        category_name: "Video Games > Xbox One > Accessories > Controllers",
        category_url:  "https://www.amazon.ca/b/?node=6920179011",
        rank:          "17",
        dimensions:    "16.5 x 13.5 x 3.8 cm ; 177 g"
      }
    end

    it { should eq expected_response }
  end
end
