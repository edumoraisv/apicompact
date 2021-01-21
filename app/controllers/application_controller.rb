# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

  def current_user
    token = request.headers['Authorization']
    find_or_initilize_user(token)
  end

  def find_or_initilize_user(token)
    firebase_response = HTTParty.post(
      "https://www.googleapis.com/identitytoolkit/v3/relyingparty/getAccountInfo?key=#{ENV['FIREBASE_API_KEY']}",
      headers: { 'Content-Type' => 'application/json' },
      body: { 'idToken' => token }.to_json
    )

    User.find_by(email: firebase_response['users'].first['email'])
  end
end
