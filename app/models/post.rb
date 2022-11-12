class Post < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { maximum: 65_535 }

  enum emotional_state: { depressed: 0, motivation: 1, relax: 2 }
end
