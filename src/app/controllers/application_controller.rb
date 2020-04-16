class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate!

  private

  def authenticate!
    authenticate_or_request_with_http_token do |token, options|
      (user = User.find_by(token: token)) && user.activated
    end
  end

  def current_user
    @current_user ||= User.find_by(token: request.headers['Authorization'].split[1]) if request.headers['Authorization']
  end
end
