# frozen_string_literal: true

module Types
  module Core
    class User < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: true
      field :email, String, null: false
      field :avatar_url, String, null: true
      field :roles, [UserRoles], null: false
      field :active_review_requests, [Types::Review::Request], null: false

      def avatar_url
        Rails.application.routes.url_helpers.rails_blob_url(object.avatar, only_path: true)
      rescue ActionController::UrlGenerationError
        nil
      end

      def roles
        object.roles.map(&:name)
      end
    end
  end
end
