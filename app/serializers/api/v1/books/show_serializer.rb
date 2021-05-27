module Api
  module V1
    module Books
      class ShowSerializer < ActiveModel::Serializer
        attributes :id, :filename, :status

        has_many :contacts#, serializer: Api::V1::Contacts::IndexSerializer
        has_many :invalid_contacts#, serializer: Api::V1::Contacts::IndexSerializer
      end
    end
  end
end
