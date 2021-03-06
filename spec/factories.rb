FactoryGirl.define do
  factory :task do
    user
    description "Feed the pigs"
  end

  factory :user do
    sequence(:email) {|n| " user#{n}@email.com" }
    password '12345678'
    password_confirmation '12345678'
  end
end