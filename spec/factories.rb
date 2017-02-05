FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com"}
    password "foobar123"
    password_confirmation "foobar123"

    factory :admin do
      admin true
    end
  end
end

FactoryGirl.define do
  factory :item_image do
    image { fixture_file_upload(Rails.root.join('spec', 'photos', 'corgi.jpg'), 'image/jpg') }
  end
end

FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "moby dick #{n}" }
    sequence(:description) { |n| "great book about whale #{n}" }
    user
    location
    category
  end
end

FactoryGirl.define do
  factory :location do
    sequence(:city) { |n| "HCM #{n}" }
  end
end

FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "book #{n}" }
  end
end
