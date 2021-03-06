module Api
  module V1
    class IdeasController < ApplicationController
      def index
        if !(params[:page] && params[:limit])
          render status: 400, :json => { status: "400", message: "page and limit are required" }
          return
        end

        @ideas = Idea.where(status: true, user_id: current_user.id)

        # sort機能
        if params["sort"]
          case params["sort"]
            when "new" then
              @ideas = @ideas.order(created_at: :desc)
            when "old" then
              @ideas = @ideas.order(:created_at)
            when "high" then
              @ideas = @ideas.order(priority: :desc)
            when "low" then
              @ideas = @ideas.order(:priority)
            end
        end

        # word検索
        if params[:word]
          @ideas = @ideas.where("title LIKE ? OR detail LIKE ?", "%#{params[:word]}%", "%#{params[:word]}%")
        end

        # idea_tagsの絞り込み
        if params[:idea_tags]
          matchAllIdeaTags = IdeaIdeaTag.where(idea_tag_id: params[:idea_tags].split(",")).group(:idea_id).select(:idea_id).having('count(idea_id) >= ?', params[:idea_tags].split(",").length)
          ideaIds = matchAllIdeaTags.map(&:idea_id)
          @ideas = @ideas.where(id: ideaIds)
        end

        # genre_tagsの絞り込み
        if params[:genre_tags]
          matchAllGenreTags = IdeaGenreTag.where(genre_tag_id: params[:genre_tags].split(",")[0]).group(:idea_id).select(:idea_id).having('count(idea_id) = ?', 1)
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
           # 複合アイデア用
          if idea_params[:ideas]
            ids = idea_params[:ideas]
            ids.each do |id|
              temp = Idea.find(id["id"])
              idea.includeIdeas(temp)
            end
          end
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
        idea.user_id = current_user.id
        tag_update(idea, idea_params)
        if idea.update(idea_params[:idea])
          # 複合アイデア用
          if idea_params[:ideas]
            ids = idea_params[:ideas]
            ids.each do |id|
              temp = Idea.find(id["id"])
              idea.includeIdeas(temp)
            end
          end
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
            :ideas => [:id],
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
          if idea_params[:genre_tag] && idea_params[:genre_tag][:id] != 0
            genre_tags.push GenreTag.find(idea_params[:genre_tag][:id])
          end
  
          idea.idea_tags = idea_tags
          idea.genre_tags = genre_tags
        end
    end
  end
end