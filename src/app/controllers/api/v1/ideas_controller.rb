module Api
  module V1
    class IdeasController < ApplicationController

      def index
        if !(params[:page] && params[:limit])
          render status: 400, :json => { status: "400", message: "page and limit required" }
          return
        end

        # pagination
        page = params[:page] ? params[:page].to_i : 1
        limit = params[:limit] ? params[:limit].to_i : 25
        offset = limit * (page - 1);

        render :json => current_user.ideas.where(status: true).limit(limit).offset(offset), adapter: :json, :each_serializer => IdeaSerializer, root: "data"
      end

      def show
        render :json => Idea.find(params[:id]), :serializer => IdeaSerializer
      end

      def create
        idea = Idea.new(idea_params)
        if idea.save
          render :json => idea, :serializer => IdeaSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      def destroy
        idea = Idea.find(params[:id])
        if idea.update(status: false)
          render :json => idea, :serializer => IdeaSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      def update
        idea = Idea.find(params[:id])
        if idea.update(idea_params)
          render :json => idea, :serializer => IdeaSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      private
        def idea_params
          params.require(:idea).permit(:user_id, :title, :detail, :priority)
        end
    end
  end
end