class ImportContactJob < ApplicationJob
  def perform(book_id)
    book = Book.find_by(id: book_id)
    return unless book
  end
end
