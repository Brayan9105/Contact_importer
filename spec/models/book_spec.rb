require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'valid factory' do
    it { expect(build(:book, :on_hold)).to be_valid }
    it { expect(build(:book, :processing)).to be_valid }
    it { expect(build(:book, :failed)).to be_valid }
    it { expect(build(:book, :terminated)).to be_valid }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:contacts) }
    it { should have_many(:invalid_contacts)}
  end

  describe 'validations' do
    it { should validate_presence_of(:file) }
  end
end
