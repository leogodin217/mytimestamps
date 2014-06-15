FactoryGirl.define do 
  factory :user do 
    sequence(:email) { |n| "user#{n}@example.com"}
    sequence(:password) { |n| "password#{n}"}
  end
  
  factory :activity do 
    sequence(:name) { |n| "activity #{n}" }
    user 
  end

end