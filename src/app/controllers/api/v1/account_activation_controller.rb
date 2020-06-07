module Api
  module V1
    class AccountActivationsController < ApplicationController
      skip_before_action :authenticate!, only: [:edit, :create]
      include ActionController::Cookies
      def edit
        user = User.find_by(email: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
          user.activate
          cookies['token'] = {value: user.token, domain: 'stockroom.work'}
          redirect_to 'https://stockroom.work/home'
        else
          render status: 400, :json => { status: "400", errors: "invalid activation link" }
        end
      end

      def create
        auth = request.env["omniauth.auth"]
        if auth.present?
          unless @auth = Authorization.find_from_auth(auth)
            @auth = Authorization.create_from_auth(auth)
          end
          user = @auth.user
          cookies['token'] = {value: user.token, domain: 'stockroom.work'}
          redirect_to 'https://stockroom.work/home'
        end
      end
    end
  end
end