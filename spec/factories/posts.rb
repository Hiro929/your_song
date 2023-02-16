FactoryBot.define do
  factory :post do
    user { nil }
    track_id { "MyString" }
    emotional_state { 1 }
    body { "MyText" }
  end
end
