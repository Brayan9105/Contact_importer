require 'rails_helper'

RSpec.describe ContactImporterService do
  let(:user){ create(:user) }

  describe 'import' do
    let(:book){ create(:book, :valid_file, user: user) }
    subject{ described_class.new(book, user) }

    context 'when all contacts are valid' do
      it 'returns terminated ' do
        expect(subject.import).to eq('terminated')
      end
    end

    context 'when some colums are different from 6' do
      let(:book){ create(:book, :invalid_book, user: user) }
      subject{ described_class.new(book, user) }

      it 'returns failed book status' do
        expect(subject.import).to eq('failed')
      end
    end

    context 'when some contacts are not valid' do
      let(:book){ create(:book, :failed_book, user: user) }
      subject{ described_class.new(book, user) }

      it 'returns failed book status' do
        expect(subject.import).to eq('failed')
      end
    end
  end
end
