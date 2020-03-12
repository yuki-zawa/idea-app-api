module Api
  module V1
    class MultiIdeasController < ApplicationController

      def index
        if !(params[:page] && params[:limit])
          render status: 400, :json => { status: "400", message: "page and limit required" }
          return
        end

        # pagination
        page = params[:page] ? params[:page].to_i : 1
        limit = params[:limit] ? params[:limit].to_i : 25
        offset = limit * (page - 1);

        render :json => MultiIdea.where(status: true).limit(limit).offset(offset), adapter: :json, :each_serializer => MultiIdeaSerializer, root: "data"
      end

      def show
        render :json => MultiIdea.find(params[:id]), :serializer => MultiIdeaSerializer
      end

      def create
        multiIdea = MultiIdea.new(multi_idea_params)
        if multiIdea.save
          render :json => multiIdea, :serializer => MultiIdeaSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      def destroy
        multiIdea = MultiIdea.find(params[:id])
        if multiIdea.update(status: false)
          render :json => multiIdea, :serializer => MultiIdeaSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      def update
        multiIdea = MultiIdea.find(params[:id])
        if multiIdea.update(multi_idea_params)
          render :json => multiIdea, :serializer => MultiIdeaSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      private
        def multi_idea_params
          params.require(:multi_idea).permit(:title, :detail, :priority)
        end
    end
  end
end