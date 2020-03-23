# frozen_string_literal: true

RSpec.describe Product, type: :model do

  context 'schema' do
    it { should have_db_column(:asin).of_type(:string) }
    it { should have_db_column(:category_name).of_type(:string) }
    it { should have_db_column(:category_url).of_type(:string) }
    it { should have_db_column(:dimensions).of_type(:string) }
    it { should have_db_column(:product_title).of_type(:string) }
    it { should have_db_column(:rank).of_type(:string) }
  end

  context 'validations' do
    it { should validate_presence_of(:asin) }
    it { should validate_presence_of(:category_name) }
    it { should validate_presence_of(:category_url) }
    it { should_not validate_presence_of(:dimensions) }
    it { should validate_presence_of(:product_title) }
    it { should validate_presence_of(:rank) }
  end
end
