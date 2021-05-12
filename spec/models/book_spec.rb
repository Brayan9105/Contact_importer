require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'factory' do
    context 'when is valid' do
      it { expect(build(:book, :valid_file, :on_hold)).to be_valid }
      it { expect(build(:book, :valid_file, :processing)).to be_valid }
      it { expect(build(:book, :valid_file, :failed)).to be_valid }
      it { expect(build(:book, :valid_file, :terminated)).to be_valid }
    end

    context 'when is not valid' do
      it { expect(build(:book, :invalid_file, :terminated)).not_to be_valid }
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:contacts) }
    it { should have_many(:invalid_contacts)}
  end

  describe 'validations' do
    it { should validate_presence_of(:file) }
    it { should validate_presence_of(:column_name) }
    it { should validate_presence_of(:column_dob) }
    it { should validate_presence_of(:column_phone) }
    it { should validate_presence_of(:column_address) }
    it { should validate_presence_of(:column_credit_card) }
    it { should validate_presence_of(:column_franchise) }
    it { should validate_presence_of(:column_email) }

    it { should validate_inclusion_of(:column_name).in_range(1..7) }
    it { should validate_inclusion_of(:column_dob).in_range(1..7) }
    it { should validate_inclusion_of(:column_phone).in_range(1..7) }
    it { should validate_inclusion_of(:column_address).in_range(1..7) }
    it { should validate_inclusion_of(:column_credit_card).in_range(1..7) }
    it { should validate_inclusion_of(:column_franchise).in_range(1..7) }
    it { should validate_inclusion_of(:column_email).in_range(1..7) }

    context 'diferent_index' do
      context 'when all index are different' do
        let(:valid_book){ build(:book, :valid_file) }
        it 'return nil' do
          expect(valid_book.different_index).to be_nil
        end
      end

      context 'when some index are equal' do
        let(:invalid_book){ build(:book, :valid_file, column_dob: 1) }
        it 'return a validation error' do
          expect(invalid_book.different_index).not_to be_nil
        end
      end
    end

    context 'csv_format' do
      context 'when is a csv file' do
        let(:valid_book){ build(:book, :valid_file) }
        it 'return nil' do
          expect(valid_book.csv_format).to be_nil
        end
      end

      context 'when is not a csv file' do
        let(:invalid_book){ build(:book, :invalid_file) }
        it 'return a validation error' do
          expect(invalid_book.csv_format).not_to be_nil
        end
      end
    end
  end

  describe 'callbacks' do
    context 'after_create' do
      context 'set_filename' do
        let(:book){ build(:book, :valid_file, :without_filename) }
        it 'set filename with the name of the file uploaded' do
          expect{ book.save }.to change(book, :filename).from("").to("csv_file.csv")
        end
      end
    end
  end
end
