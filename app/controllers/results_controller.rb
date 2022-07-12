class ResultsController < ApplicationController
  
  def new; end

  def create; end

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
                     emotion: "あなたはとてもハッピーです(^o^)" 
                   }
                  elsif face_detail.emotions[0].type == 'SAD'
                    {
                      emotion: "あなたは悲しんでいます(>_<)"
                    }
                  elsif face_detail.emotions[0].type == 'ANGRY'
                    {
                      emotion: "あなたは怒っています(`A´)"
                    }
                  elsif face_detail.emotions[0].type == 'CONFUSED'
                    {
                      emotion: "あなたは困惑しています(´･ω･`)?"
                    }
                  elsif face_detail.emotions[0].type == 'DISGUSTED'
                    {
                      emotion: "あなたは嫌悪感を抱いています(´･д･`)ﾔﾀﾞ"
                    }
                  elsif face_detail.emotions[0].type == 'SURPRISED'
                    {
                      emotion: "あなたは驚いています（ﾟﾛﾟ）"
                    }
                  elsif face_detail.emotions[0].type == 'CALM'
                    {
                      emotion: "あなたは穏やかです(*´∀`*)"
                    }
                  elsif face_detail.emotions[0].type == 'FEAR'
                    {
                      emotion: "あなたは恐れています（；ﾟДﾟ）"
                    }
                  else
                    {
                      emotion: "あなたの感情は無です( ˙-˙ )"
                    }
                  end                  
      render json: @emotion
    end
  end
end
