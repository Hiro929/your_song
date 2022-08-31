class Result < ApplicationRecord
  belongs_to :song

  enum emotion: { HAPPY: 0, SAD: 1, ANGRY: 2, CONFUSED: 3, DISGUSTED: 4, SURPRISED: 5, CALM: 6, FEAR: 7, UNKNOWN: 8 }
end
