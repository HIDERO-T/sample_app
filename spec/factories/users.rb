FactoryBot.define do
  factory :user do
    sequence(:name){Faker::Name.name}
    sequence(:email){|n| "ex-#{n}@mple.jp"}
    password_digest {"#{User.digest('password')}"}
    admin {false}
    activated {true}
    activated_at {"#{Time.zone.now}"}

    factory :michael, class: User do
      name {"Michael Heartl"}
      email {"m-heartl@rails.org"}
    end
    factory :archer, class: User do
      name {"Archer Heartl"}
      email {"a-heartl@rails.org"}
    end
    factory :lana, class: User do
      name {"Lana Heartl"}
      email {"l-heartl@rails.org"}
    end
    factory :malory, class: User do
      name {"Malory Heartl"}
      email {"ma-heartl@rails.org"}
    end
  end
end

