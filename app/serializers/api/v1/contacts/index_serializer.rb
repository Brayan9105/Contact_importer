module Api
  module V1
    module Contacts
      class IndexSerializer < ActiveModel::Serializer
        attribute :id, :name, :dob, :email, :telephone,
                  :address, :credit_card, :franchise, :book_id

        belongs_to :book, serializer: Api::V1::Books::ShowSerializer
      end
    end
  end
end
