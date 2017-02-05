namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do
    User.create!( email: "batman@gmail.com",
                  phone: "555555555",
                  password: "foobar",
                  password_confirmation: "foobar",
                  admin: true)

    99.times do
      password = "password"
      User.create!( email: Faker::Internet.email,
                    phone: Faker::PhoneNumber.phone_number,
                    password: password,
                    password_confirmation: password)
    end

    10.times do
      Location.create!( city: Faker::Address.city )
    end

    6.times do
      Category.create!( name: Faker::Space.meteorite )
    end

    users = User.all.limit 20
    3.times do
      users.each do |user|
        user.items.create!( name: Faker::Food.ingredient,
                            description: Faker::ChuckNorris.fact,
                            location: Location.offset(rand(Location.count)).first,
                            category: Category.offset(rand(Category.count)).first)
      end
    end

    items = Item.all.limit 20
    3.times do
      items.each do |item|
        item.item_images.create!( image_file_name: File.open(
                      Dir.glob(
                      File.join(
                      Rails.root, 'spec/photos', '*')).sample))
      end
    end
  end
end
