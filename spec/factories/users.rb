FactoryGirl.define do
  factory :user do
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    password "123456"
    email { FFaker::Internet.email }
  end
end
