class ImportContactJob < ApplicationJob
  def perform(book_id, user)
    book = Book.find_by(id: book_id)
    return unless book

    ::ContactImporterService.new(book, user).import
  end
end
