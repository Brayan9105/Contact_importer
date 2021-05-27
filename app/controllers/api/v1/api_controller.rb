# frozen_string_literal: true

module Api
  module V1
    class ApiController < ApplicationController
      include ActionController::HttpAuthentication::Token
      skip_before_action :verify_authenticity_token

      respond_to :json

      rescue_from ActiveRecord::RecordNotFound, with: :handle_error
      rescue_from StandardError, with: :handle_error

      private

      def authenticate_user
        token, _options = token_and_options(request)
        user_id = AuthenticationTokenService.decode(token)
        @current = User.find(user_id)
      rescue ActiveRecord::RecordNotFound
        render status: :unauthorized
      end

      def current_user
        @user ||= @current
      end

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
