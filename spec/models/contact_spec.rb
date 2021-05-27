require 'rails_helper'

RSpec.describe Contact, type: :model do
  describe 'valid factory' do
    it { expect(build(:contact)).to be_valid }
  end

  describe 'methods' do
    describe 'credit_card_format' do
      let!(:contact){ create(:contact, franchise: '') }

      it 'returns franchise name' do
        expect(contact.franchise).to eq('American Express')
      end

      it 'returns the 4 first numbers' do
        expect(contact.card_digits).to eq('3714')
      end
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:telephone) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:dob) }
    it { should validate_presence_of(:credit_card) }

    describe 'date_is_iso8601' do
      context 'when field format is correct' do
        let(:contact1){ build(:contact, dob: "20210513") }
        let(:contact2){ build(:contact, dob: "2021-05-13") }

        it 'returns nil' do
          expect(contact1.date_is_iso8601).to be true
        end

        it 'returns nil' do
          expect(contact2.date_is_iso8601).to be true
        end
      end

      context 'when field format is not correct' do
        let(:invalid_contact){ build(:contact, dob: "2021/05/13") }

        it 'returns a validation error' do
          expect(invalid_contact.date_is_iso8601).not_to be_nil
        end
      end
    end

    describe 'credit_card_format' do
      describe 'credit card number is valid' do
        let(:contact){ build(:contact, credit_card: card) }

        context 'and franchise is American Express' do
          let(:card){ '371449635398431' }

          it 'return nil' do
            expect(contact.credit_card_format).to be_nil
          end
        end

        context 'and franchise is Diners Club' do
          let(:card){ '30569309025904' }

          it 'return nil' do
            expect(contact.credit_card_format).to be_nil
          end
        end

        context 'and franchise is Discover' do
          let(:card){ '6011111111111117' }

          it 'return nil' do
            expect(contact.credit_card_format).to be_nil
          end
        end
        context 'and franchise is JCB' do
          let(:card){ '3530111333300000' }

          it 'return nil' do
            expect(contact.credit_card_format).to be_nil
          end
        end

        context 'and franchise is MasterCard' do
          let(:card){ '5555555555554444' }

          it 'return nil' do
            expect(contact.credit_card_format).to be_nil
          end
        end

        context 'and franchise is Visa' do
          let(:card){ '4111111111111111' }

          it 'return nil' do
            expect(contact.credit_card_format).to be_nil
          end
        end
      end

      describe 'credit card number is no valid' do
        let(:invalid_contact){ build(:contact, credit_card: '123456789123456') }

        it 'return a validation error' do
          expect(invalid_contact.credit_card_format).not_to be_nil
        end
      end
    end
  end
end
