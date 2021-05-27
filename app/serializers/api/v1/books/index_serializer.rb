module Api
  module V1
    module Books
      class IndexSerializer < ActiveModel::Serializer
        attributes :id, :filename, :status
      end
    end
  end
end
