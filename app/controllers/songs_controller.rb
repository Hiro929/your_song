class SongsController < ApplicationController
  before_action :require_login
  before_action :check_admin
  AuthenticationService.spotify_authenticate

  def index
    @songs = Song.all.includes(:result).page(params[:page])
  end

  def new
    @song = Song.new
    @albums = RSpotify::Album.search("SUPER BEAVER", market: 'JP')
    @album = @albums.find { |album| album.name == params[:album] }
    @search_params = params[:album]
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      redirect_to songs_path, success: "#{@song.title}を登録しました！"
    else
      flash.now[:danger] = "すでに登録されているか、正常に登録されませんでした。"
      render :new
    end
  end

  def search
    if params[:album].present?
      @albums = RSpotify::Album.search(params[:album], market: 'JP')
      @search_params = params[:album]
    end
  end

  private

  def song_params
    params.require(:song).permit(:artist, :title, :acousticness, :danceability, :energy, :tempo, :valence, :album_image, :preview_url, :spotify_url)
  end

  def not_authenticated
    flash[:warning] = "ログインしてください"
    redirect_to admin_login_path
  end

  def check_admin
    redirect_to admin_login_path, warning: "権限がありません" unless current_user.admin?
  end
end
