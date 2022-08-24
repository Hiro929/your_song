class ResultsController < ApplicationController

  def show
    @result = Result.find(params[:uuid])
  end

  def new
    @result = Result.new
  end

  def create
    @result = Result.create(result_params)
    @result.save
    render json: { url: result_url(@result.uuid) }
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

    response.face_details.each do |face_detail|
      @emotion = if face_detail.emotions[0].type == 'HAPPY'
                   { 
                     body: "あなたはとてもハッピーです(^o^)" ,
                     emotion: "HAPPY"
                   }
                 elsif face_detail.emotions[0].type == 'SAD'
                   {
                     body: "あなたは悲しんでいます(>_<)",
                     emotion: "SAD"
                   }
                 elsif face_detail.emotions[0].type == 'ANGRY'
                   {
                     body: "あなたは怒っています(`A´)",
                     emotion: "ANGRY"
                   }
                 elsif face_detail.emotions[0].type == 'CONFUSED'
                   {
                     body: "あなたは困惑しています(´･ω･`)?",
                     emotion: "CONFUSED"
                   }
                 elsif face_detail.emotions[0].type == 'DISGUSTED'
                   {
                     body: "あなたは嫌悪感を抱いています(´･д･`)ﾔﾀﾞ",
                     emotion: "DISGUSTED"
                   }
                 elsif face_detail.emotions[0].type == 'SURPRISED'
                   {
                     body: "あなたは驚いています（ﾟﾛﾟ）",
                     emotion: "SURPRISED"
                   }
                 elsif face_detail.emotions[0].type == 'CALM'
                   {
                     body: "あなたは穏やかです(*´∀`*)",
                     emotion: "CALM"
                   }
                 elsif face_detail.emotions[0].type == 'FEAR'
                   {
                     body: "あなたは恐れています（；ﾟДﾟ）",
                     emotion: "FEAR"
                   }
                 else
                   {
                     body: "あなたの感情は無です( ˙-˙ )",
                     emotion: "UNKNOWN"
                   }
                 end                  
      render json: @emotion
    end
  end

  private

  def result_params
    params.require(:result).permit(:image, :emotion)
  end
end
