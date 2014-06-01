FactoryGirl.define do 
  factory :activity do 
    sequence(:name) { |n| "activity #{n}" }
  end

  factory :user do 
    email "foobar@example.com"
    password "foobar11"
  end
end