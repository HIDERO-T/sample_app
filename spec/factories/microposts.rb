FactoryBot.define do
  factory :micropost do
    sequence(:content) {Faker::Lorem.sentence(5)}
    created_at {10.minutes.ago}
  end
end
