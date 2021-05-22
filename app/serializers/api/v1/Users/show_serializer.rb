module Api
  module V1
    module Users
      class ShowSerializer < ActiveModel::Serializer
        attributes :id, :username, :email
      end
    end
  end
end
