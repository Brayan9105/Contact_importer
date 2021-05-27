require 'rails_helper'

RSpec.describe ImportContactJob, type: :job do
  include ActiveJob::TestHelper

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  let!(:current_user){ create(:user) }
  let(:book){ create(:book, :valid_file, user: current_user) }
  let(:book2){ create(:book, :failed_book, user: current_user) }
  let(:book_id){ book.id }

  describe 'perform_later' do
    let(:job){ described_class.perform_later(book, current_user) }

    it 'enqueue job' do
      expect { job }.to have_enqueued_job.with(book, current_user).on_queue('default')
    end

    context 'when book does exists' do
      context 'and all contacts are imported' do
        it '' do
          expect(subject.send(:perform, book.id, current_user)).to be_truthy
        end
      end

      context 'and some contacts or all failed' do
        it '' do
          # expect(subject.send(:perform, failed_book.id, current_user)).to be_truthy
        end
      end
    end

    context 'when book does not exists' do
      let(:job){ described_class.perform_later(nil, current_user) }

      it 'never calls ContactImporterService' do
      end
    end
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end
