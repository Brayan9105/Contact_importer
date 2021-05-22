# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken

      # before_action :authenticate_user!

      respond_to :json

      rescue_from ActiveRecord::RecordNotFound, with: :handle_error
      rescue_from StandardError, with: :handle_error

      private

      def render_collection(scope, root:, serializer:)
        render json: scope,
               root: root,
               each_serializer: serializer,
               adapter: :json
      end

      def render_response(object, serializer:, status:)
        render json: object,
               serializer: serializer,
               status: status
      end

      def handle_error(e)
        status = e.is_a?(ActiveRecord::RecordNotFound) ? :not_found : :bad_request
        render json: { error: e.to_s }, status: status
      end
    end
  end
end
