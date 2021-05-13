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
      context 'when field format is correct' do
        let(:contact1){ build(:contact, dob: "20210513") }
        let(:contact2){ build(:contact, dob: "2021-05-13") }

        it 'returns nil' do
          expect(contact1.valid_date).to be true
        end

        it 'returns nil' do
          expect(contact2.valid_date).to be true
        end
      end

      context 'when field format is not correct' do
        let(:invalid_contact){ build(:contact, dob: "2021/05/13") }

        it 'returns a validation error' do
          expect(invalid_contact.valid_date).not_to be_nil
        end

        it 'returns a validation error' do
          invalid_contact.dob = ''
          expect(invalid_contact.valid_date).not_to be_nil
        end
      end
    end

    describe 'valid_phone' do
      context 'when field format is valid' do
        let(:contact1){ build(:contact, telephone: "(+00) 000 000 00 00") }
        let(:contact2){ build(:contact, telephone: "(+00) 000-000-00-00") }

        it 'returns nil' do
          expect(contact1.valid_phone).to be_nil
        end

        it 'returns nil' do
          expect(contact2.valid_phone).to be_nil
        end
      end

      context 'when field format is not valid' do
        let(:invalid_contact){ build(:contact, telephone: "(+00) 0000000000") }

        it 'returns a validation error' do
          expect(invalid_contact.valid_phone).not_to be_nil
        end
      end
    end

    describe 'valid_address' do
    end

    describe 'valid_credit_card' do
    end

    describe 'valid_email' do
    end
  end
end
