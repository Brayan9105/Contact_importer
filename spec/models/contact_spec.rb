require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'valid factory' do
    it { expect(build(:contact)).to be_valid }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  describe 'validations' do
    it { should validate_presence_of(:telephone) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:credit_card) }
    it { should validate_presence_of(:franchise) }
    it { should validate_presence_of(:email) }
  end
end
