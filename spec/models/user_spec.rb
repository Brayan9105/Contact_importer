require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'valid factory' do
    it { expect(build(:user)).to be_valid }
  end

  describe 'associations' do
    it { should have_many(:books) }
    it { should have_many(:contacts) }
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
  end
end
