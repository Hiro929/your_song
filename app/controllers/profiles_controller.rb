class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show
    @posts = Post.where(user_id: current_user.id).includes(:user).order(created_at: :desc).page(params[:page]).per(9)
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to profile_path, success: "ユーザーを更新しました！"
    else
      flash.now[:danger] = "ユーザーを更新できませんでした！"
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name, :email, :best_song)
  end
end
