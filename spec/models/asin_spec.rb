# frozen_string_literal: true

RSpec.describe Asin, type: :model do

  context 'schema' do
    it { should have_db_column(:category_name).of_type(:string).with_options(null: false) }
    it { should have_db_column(:category_url).of_type(:string).with_options(null: false) }
    it { should have_db_column(:dimensions).of_type(:string).with_options(null: false) }
    it { should have_db_column(:rank).of_type(:string).with_options(null: false) }
  end

  context 'validations' do
    subject { create(:rocket) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:type_name) }
    it { should validate_uniqueness_of(:reference_number).presence }
  end
end
