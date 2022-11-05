class AuthenticationService
  def self.spotify_authenticate
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])
  end
end