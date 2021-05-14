class ImportContactJob < ApplicationJob
  def perform(book_id, user)
    book = Book.find_by(id: book_id)
    return unless book

    book.processing!
    ::ContactImporterService.new(book, user).import
    book.invalid_contacts.count.positive? ? book.failed! : book.terminated!
  end
end
