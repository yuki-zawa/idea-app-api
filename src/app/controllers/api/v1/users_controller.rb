module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :authenticate!, only: [:create, :sign_in]
      include ActionController::Cookies

      def index
        if !(params[:page] && params[:limit])
          render status: 400, :json => { status: "400", message: "page and limit required" }
          return
        end

        # pagination 
        page = params[:page] ? params[:page].to_i : 1
        limit = params[:limit] ? params[:limit].to_i : 25
        offset = limit * (page - 1);

        render :json => User.limit(limit).offset(offset), :each_serializer => UserSerializer
      end

      def show
        render :json => User.find(params[:id]), :serializer => UserSerializer
      end

      def create
        @before_user = User.find_by(email: params[:email])
        if @before_user && !@before_user.activated
          @before_user.destroy
        end
        @user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])

        if @user.save
          @user.send_activation_email
          render json: { messages: "Please check your email to activate your account." }
        else
          render json: { errors: @user.errors.full_messages }, status: 400
        end
      end

      def sign_in
        @user = User.find_by(email: params[:email])

        if @user && @user.authenticate(params[:password])
          render json: @user
        else
          render json: { errors: ['failed to login'] }, status: 401
        end
      end

      def destroy
        if current_user.destroy
          redirect_to 'https://stockroom.work'
        else
          render status: 400, :json => { status: "400", message: "failed" }
        end
      end

      def update
        begin
          cookies['token'] = {value: "", domain: '.stockroom.work', expires: Time.at(0)}
          render json: { messages: "ok" }
        rescue => e
          logger.error e 
        end
      end

      def me
        render json: current_user, :serializer => UserSerializer
      end

      private

    end
  end
end