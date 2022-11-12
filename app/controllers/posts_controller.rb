class PostsController < ApplicationController
  AuthenticationService.spotify_authenticate

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    @track_id = params[:track_id]
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: "投稿しました！"
    else
      flash.now[:danger] = "投稿に失敗しました！"
      render search_posts_path
    end
  end

  def search
    if params[:track].present?
      @tracks = RSpotify::Track.search(params[:track], market: 'JP', limit: 9)
      @search_params = params[:track]
    end
  end

  private

  def post_params
    params.require(:post).permit(:track_id, :emotional_state, :body)
  end
end
