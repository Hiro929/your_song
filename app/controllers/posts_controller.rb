class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy]
  AuthenticationService.spotify_authenticate

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(9)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :asc)
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
      render :search
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post, success: "投稿を更新しました！"
    else
      flash.now[:danger] = "投稿を更新できませんでした！"
      render :edit
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, success: "投稿を削除しました！"
  end

  def search
    if params[:track].present?
      @tracks = RSpotify::Track.search(params[:track], market: 'JP', limit: 9)
      @search_params = params[:track]
    end
  end

  private

  def find_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:track_id, :emotional_state, :body)
  end
end
