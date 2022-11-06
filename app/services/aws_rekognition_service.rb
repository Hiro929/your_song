class AwsRekognitionService
  def self.check_emotion(photo)
    credentials = Aws::Credentials.new(
      ENV['AWS_ACCESS_KEY_ID'],
      ENV['AWS_SECRET_ACCESS_KEY']
    )
    client = Aws::Rekognition::Client.new credentials: credentials
    attrs = {
      image: {
        bytes: photo
      },
      attributes: ['ALL']
    }

    return client.detect_faces attrs
  end
end