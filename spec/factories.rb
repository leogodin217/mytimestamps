FactoryGirl.define do 
  factory :user do 
    email "foobar@example.com"
    password "foobar11"
  end
  
  factory :activity do 
    sequence(:name) { |n| "activity #{n}" }
    user 
  end

end