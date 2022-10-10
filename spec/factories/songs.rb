FactoryBot.define do
  factory :song do
    artist { "SUPER BEAVER" }
    sequence(:title) { |n| "title-#{n}" }
    album_image { "MyString" }
    preview_url { "MyString" }
    spotify_url { "MyString" }
    acousticness { 1 }
    danceability { 1 }
    energy { 1 }
    tempo { 1 }
    valence { 1 }
  end
end
