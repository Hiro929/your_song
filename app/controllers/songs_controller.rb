class SongsController < ApplicationController
  require 'rspotify'
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

  def index
    @songs = Song.all
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
      flash[:notice] = "#{@song.title}を登録しました！"
      redirect_to new_song_path
    else
      flash.now[:alert] = "すでに登録されているか、正常に登録されませんでした。"
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
end
