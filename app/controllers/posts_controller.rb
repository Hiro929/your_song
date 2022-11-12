class PostsController < ApplicationController
  AuthenticationService.spotify_authenticate

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def search
    if params[:track].present?
      @tracks = RSpotify::Track.search(params[:track], market: 'JP', limit: 9)
      @search_params = params[:track]
    end
  end
end
