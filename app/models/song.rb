class Song < ApplicationRecord
  has_many :result

  validates :title, uniqueness: true
  validates :preview_url, uniqueness: true
  validates :spotify_url, uniqueness: true
end
