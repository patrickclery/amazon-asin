# frozen_string_literal: true

RSpec.describe AmazonAsin do
  subject(:object) { described_class.new(asin) }

  context "Valid ASIN" do
    let(:asin) { Faker::Code.asin }
    # Testing that it doesn't raise an error
    it { expect(subject).to eq asin }

    describe ".to_url" do
      it { expect(object).to respond_to(:to_url) }
      it { expect(object.to_url).to eq "https://www.amazon.ca/dp/#{asin}" }
    end
  end
  context "Invalid ASIN" do
    let(:asin) { "g1b3r1sh" }
    it { expect { subject }.to raise_error("Invalid ASIN") }
  end
end
