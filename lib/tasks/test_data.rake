namespace :db do
  desc "Fill database with sample data"

  task populate: :environment do
    User.create!( email: "batman@gmail.com",
                  phone: "555555555",
                  password: "foobar",
                  password_confirmation: "foobar",
                  admin: true)

    User.create!( email: "robin@gmail.com",
                  phone: "555555550",
                  password: "foobar",
                  password_confirmation: "foobar")

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

    4.times do
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

    items = Item.all
    items.each do |item|
      2.times do
        item.item_images.create!( image: File.open(
                    Dir.glob(
                    File.join(
                    Rails.root, 'spec/photos', '*')).sample))
      end
    end

    items = Item.all
    g1_items = items[1..30]
    g2_items = items[31..59]

    for i in 0..20
      g1_items[i].follow! g2_items[i]
      g2_items[i].follow! g1_items[i]
    end

  end
end
