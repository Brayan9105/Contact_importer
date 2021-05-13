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
    it { should validate_presence_of(:email) }

    describe 'valid_name' do
      context 'when field format is correct' do
        let(:contact){ build(:contact) }

        it 'returns nil' do
          expect(contact.valid_name).to be_nil
        end
      end

      context 'when field format is not correct' do
        let(:invalid_contact){ build(:contact, name: '@pedro') }

        it 'returns a validation error' do
          expect(invalid_contact.valid_name).not_to be_nil
        end

        it 'returns a validation error' do
          invalid_contact.name = ''
          expect(invalid_contact.valid_name).not_to be_nil
        end
      end
    end

    describe 'valid_dob' do
    end

    describe 'valid_phone' do
    end

    describe 'valid_address' do
    end

    describe 'valid_credit_card' do
    end

    describe 'valid_email' do
    end
  end
end
