require 'rails_helper'

RSpec.describe InvalidContact, type: :model do
  describe 'valid factory' do
    it { expect(build(:contact)).to be_valid }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end
end
