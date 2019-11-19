FactoryBot.define do
  #Create user for testing authentication
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    sequence :username do |n|
      "user#{n}"
    end
    password { "secretPassword" }
    password_confirmation { "secretPassword" }
  end
  factory :game do
    name { "Test Name" }
  end
end