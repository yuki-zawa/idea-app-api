module Api
  module V1
    class IdeasController < ApplicationController

      def index
        if !(params[:page] && params[:limit])
          render status: 400, :json => { status: "400", message: "page and limit are required" }
          return
        end

        @ideas = Idea.where(status: true, user_id: current_user.id)

        # idea_tagsの絞り込み
        if params[:idea_tags]
          matchAllIdeaTags = IdeaIdeaTag.where(idea_tag_id: params[:idea_tags]).group(:idea_id).select(:idea_id)
          ideaIds = matchAllIdeaTags.map(&:idea_id)
          @ideas = @ideas.where(id: ideaIds)
        end

        # genre_tagsの絞り込み
        if params[:genre_tags]
          matchAllGenreTags = IdeaGenreTag.where(genre_tag_id: params[:genre_tags]).group(:idea_id).select(:idea_id)
          ideaIds = matchAllGenreTags.map(&:idea_id)
          @ideas = @ideas.where(id: ideaIds)
        end

        # pagination
        page = params[:page] ? params[:page].to_i : 1
        limit = params[:limit] ? params[:limit].to_i : 25
        offset = limit * (page - 1);

        total = @ideas.count

        render :json => @ideas.limit(limit).offset(offset), adapter: :json, :each_serializer => IdeaSerializer, root: "data", meta: {total: total, perPage: limit, currentPage: page}
      end

      def show
        render :json => Idea.find(params[:id]), :serializer => IdeaSerializer
      end

      def create
        idea = Idea.new(idea_params[:idea])
        idea.user_id = current_user.id
        tag_update(idea, idea_params)

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
        tag_update(idea, idea_params)
        if idea.update(idea_params[:idea])
          render :json => idea, :serializer => IdeaSerializer
        else
          render status: 400, :json => { status: "400", message: "validate error" }
        end
      end

      def random
        render :json => current_user.ideas.where(status: true).sample(2), adapter: :json, :each_serializer => IdeaSerializer, root: "data"
      end

      private
        def idea_params
          params
          .permit(
            :idea => [:icon, :title, :detail, :priority],
            :idea_tags => [:id],
            :genre_tag => [:id],
          )
        end

        def tag_update idea, idea_params = []
          idea_tags = []
          genre_tags = []
          if idea_params[:idea_tags]
            idea_params[:idea_tags].each do |idea_tag_param|
              idea_tag = IdeaTag.find(idea_tag_param[:id])
              idea_tags.push idea_tag
            end
          end
          if idea_params[:genre_tag]
            genre_tags.push GenreTag.find(idea_params[:genre_tag][:id])
          end
  
          idea.idea_tags = idea_tags
          idea.genre_tags = genre_tags
        end
    end
  end
end