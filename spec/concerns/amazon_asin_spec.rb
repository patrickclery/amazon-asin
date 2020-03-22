# frozen_string_literal: true

RSpec.describe AmazonAsin do
  subject { described_class.new(asin) }

  context "Valid ASIN" do
    let(:asin) { Faker::Code.asin }
    it { expect(subject).to be_valid }

    describe ".to_url" do
      it { expect(subject).to respond_to(:to_url) }
      it { expect(subject.to_url).to eq "https://www.amazon.ca/dp/#{asin}" }
    end
  end
  context "Invalid ASIN" do
    let(:asin) { "g1b3r1sh" }
    it { expect(subject).not_to be_valid }
  end
end
