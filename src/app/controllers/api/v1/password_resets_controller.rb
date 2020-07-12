module Api
  module V1
    class PasswordResetsController < ApplicationController
      before_action :get_user,   only: [:edit, :update]
      before_action :valid_user, only: [:edit, :update]
      before_action :check_expiration, only: [:edit, :update] 
      skip_before_action :authenticate!, only: [:edit, :update, :create]

      def create
        @user = User.find_by(email: params[:email].downcase)
        if @user
          @user.create_reset_digest
          @user.send_password_reset_email
        else
          render status: 400, :json => { status: "400", message: "no user error" }
        end
      end

      def update
        if @user && params[:user][:password].empty?
          render status: 400, :json => { status: "400", message: "password is blank" }
        elsif @user.update_attributes(user_params)
          @user.update_attribute(:reset_digest, nil)
        else
          render status: 400, :json => { status: "400", message: "password is wrong" }
        end
      end

      def edit
        # セキュリティ的にまずそう
        redirect_to 'https://stockroom.work/password/reset?token=' + @user.reset_digest + '&email=' + @user.email
      end

      private
        def user_params
          params.require(:user).permit(:password, :password_confirmation)
        end

        def get_user
          @user = User.find_by(email: params[:email])
        end

        # 正しいユーザーかどうか確認する
        def valid_user
          unless (@user && @user.activated? && (params[:id] == @user.reset_digest ||  @user.authenticated?(:reset, params[:id])))
            render status: 400, :json => { status: "400", message: "user is invalid" }
          end
        end
        # トークンが期限切れかどうか確認する
        def check_expiration
          if @user.password_reset_expired?
            render status: 400, :json => { status: "400", message: "token is invalid" }
          end
        end
    end
  end
end
