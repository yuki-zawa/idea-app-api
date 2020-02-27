module Api
  module V1
    class IdeaTagsController < ApplicationController

      def index
        if !(params[:page] && params[:limit])
          render status: 400, :json => { status: "400", message: "page and limit required" }
          return
        end

        # pagination
        page = params[:page] ? params[:page].to_i : 1
        limit = params[:limit] ? params[:limit].to_i : 25
        offset = limit * (page - 1);

        render :json => IdeaTag.where(status: true).limit(limit).offset(offset), adapter: :json, :each_serializer => IdeaTagSerializer, root: "data"
      end

      def show
        render :json => IdeaTag.find(params[:id]), :serializer => IdeaTagSerializer
      end

      def create
        ideaTag = IdeaTag.new(idea_tag_params)
        if ideaTag.save
          render :json => ideaTag, :serializer => IdeaTagSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      def destroy
        ideaTag = IdeaTag.find(params[:id])
        if ideaTag.update(status: false)
          render :json => ideaTag, :serializer => IdeaTagSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      def update
        ideaTag = IdeaTag.find(params[:id])
        if ideaTag.update(idea_tag_params)
          render :json => ideaTag, :serializer => IdeaTagSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      private
        def idea_tag_params
          params.require(:idea_tag).permit(:name)
        end
    end
  end
end