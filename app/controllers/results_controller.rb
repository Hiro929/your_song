class ResultsController < ApplicationController

  def show
    @result = Result.find(params[:id]) 
  end

  def new
    @result = Result.new
  end

  def create
    @result = Result.new(result_params)
    if @result.save
      redirect_to result_path(@result.id)
    end
  end

  def analysis
    credentials = Aws::Credentials.new(
      ENV['AWS_ACCESS_KEY_ID'],
      ENV['AWS_SECRET_ACCESS_KEY']
    )
    photo = Base64.decode64(params[:image])
    client = Aws::Rekognition::Client.new credentials: credentials
    attrs = {
      image: {
        bytes: photo
      },
      attributes: ['ALL']
    }
    # 分析結果の取得
    response = client.detect_faces attrs

    if response.face_details == []
      @songs = Song.all
      @song = @songs.sample
      render json: {
        body: "分析失敗(>_<)(顔が写っていない等)",
        emotion: "UNKNOWN",
        song_id: @song.id
      }
    else
      response.face_details.each do |face_detail|
        @emotion = if face_detail.emotions[0].type == 'HAPPY'
                     @songs = Song.where(
                       'acousticness <= ? and danceability >= ? or valence >= ?',
                       0.0038, 0.4, 0.7
                     )
                     @song = @songs.sample
                     { 
                       body: "あなたはとてもハッピーです(^o^)" ,
                       emotion: "HAPPY",
                       song_id: @song.id
                     }
                   elsif face_detail.emotions[0].type == 'SAD'
                     @songs = Song.where(
                       'valence > ? or acousticness >= ? or danceability <= ?',
                       0.5, 0.0039, 0.39
                     )
                     @song = @songs.sample
                     {
                       body: "あなたは悲しんでいます(>_<)",
                       emotion: "SAD",
                       song_id: @song.id
                     }
                   elsif face_detail.emotions[0].type == 'ANGRY'
                     @songs = Song.where(
                       'tempo >= ? and tempo <= ? or acousticness >= ?', 
                       90, 150, 0.0039
                     )
                     @song = @songs.sample
                     {
                       body: "あなたは怒っています(`A´)",
                       emotion: "ANGRY",
                       song_id: @song.id
                     }
                   elsif face_detail.emotions[0].type == 'CONFUSED'
                     @songs = Song.where('acousticness >= ?', 0.0039)
                     @song = @songs.sample
                     {
                       body: "あなたは困惑しています(´･ω･`)?",
                       emotion: "CONFUSED",
                       song_id: @song.id
                     }
                   elsif face_detail.emotions[0].type == 'DISGUSTED'
                     @songs = Song.where('acousticness <= ? or valence >= ?', 0.0038, 0.6)
                     @song = @songs.sample
                     {
                       body: "あなたはうんざりしています( ≖_≖​)ﾊｧ･･･",
                       emotion: "DISGUSTED",
                       song_id: @song.id
                     }
                   elsif face_detail.emotions[0].type == 'SURPRISED'
                     @songs = Song.where('tempo >= ? and tempo <= ? or acousticness >= ?', 90, 150, 0.0039)
                     @song = @songs.sample
                     {
                       body: "あなたは驚いています（ﾟﾛﾟ）",
                       emotion: "SURPRISED",
                       song_id: @song.id
                     }
                   elsif face_detail.emotions[0].type == 'CALM'
                     @songs = Song.where('acousticness <= ? or energy >= ?', 0.0039, 0.85)
                     @song = @songs.sample
                     {
                       body: "あなたは穏やかです(*´∀`*)",
                       emotion: "CALM",
                       song_id: @song.id
                     }
                   elsif face_detail.emotions[0].type == 'FEAR'
                     @songs = Song.where('acousticness <= ? or valence >= ?', 0.0038, 0.6)
                     @song = @songs.sample
                     {
                       body: "あなたは恐れています（；ﾟДﾟ）",
                       emotion: "FEAR",
                       song_id: @song.id
                     }
                   else
                     @songs = Song.where(
                       'valence > ? or acousticness >= ? or danceability <= ?',
                       0.5, 0.0039,0.39
                     )
                     @song = @songs.sample
                     {
                       body: "あなたの感情は無です( ˙-˙ )",
                       emotion: "UNKNOWN",
                       song_id: @song.id
                     }
                   end                  
        render json: @emotion
      end
    end
  end

  private

  def result_params
    params.require(:result).permit(:image, :emotion, :song_id)
  end
end
