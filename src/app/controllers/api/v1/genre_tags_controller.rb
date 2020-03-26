module Api
  module V1
    class GenreTagsController < ApplicationController

      def index
        if !(params[:page] && params[:limit])
          render status: 400, :json => { status: "400", message: "page and limit required" }
          return
        end

        # pagination
        page = params[:page] ? params[:page].to_i : 1
        limit = params[:limit] ? params[:limit].to_i : 25
        offset = limit * (page - 1);

        total = GenreTag.where(status: true).select{|e| e.ideas.select{|idea| idea.user.id == current_user.id}.present?}.count

        render :json => GenreTag.where(status: true).limit(limit).offset(offset).select{|e| e.ideas.select{|idea| idea.user.id == current_user.id}.present?}, adapter: :json, :each_serializer => GenreTagSerializer, root: "data", meta: {total: total, perPage: limit, currentPage: page}
      end

      def show
        render :json => GenreTag.find(params[:id]), :serializer => GenreTagSerializer
      end

      def create
        genreTag = GenreTag.new(genre_tag_params)
        if genreTag.save
          render :json => genreTag, :serializer => GenreTagSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      def destroy
        genreTag = GenreTag.find(params[:id])
        if genreTag.update(status: false)
          render :json => genreTag, :serializer => GenreTagSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      def update
        genreTag = GenreTag.find(params[:id])
        if genreTag.update(genre_tag_params)
          render :json => genreTag, :serializer => GenreTagSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      private
        def genre_tag_params
          params.require(:genre_tag).permit(:name, :color)
        end
    end
  end
end