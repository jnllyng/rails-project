require 'net/http'
require 'json'
require 'csv'

# 1. Provinces
provinces_data = [
  { name: "Alberta", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "British Columbia", gst: 0.05, pst: 0.07, hst: 0.00 },
  { name: "Manitoba", gst: 0.05, pst: 0.07, hst: 0.00 },
  { name: "New Brunswick", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Newfoundland and Labrador", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Northwest Territories", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "Nova Scotia", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Nunavut", gst: 0.05, pst: 0.00, hst: 0.00 },
  { name: "Ontario", gst: 0.00, pst: 0.00, hst: 0.13 },
  { name: "Prince Edward Island", gst: 0.00, pst: 0.00, hst: 0.15 },
  { name: "Quebec", gst: 0.05, pst: 0.09975, hst: 0.00 },
  { name: "Saskatchewan", gst: 0.05, pst: 0.06, hst: 0.00 },
  { name: "Yukon", gst: 0.05, pst: 0.00, hst: 0.00 }
]

provinces_data.each do |p|
  Province.find_or_create_by(name: p[:name]) do |province|
    province.gst = p[:gst]
    province.pst = p[:pst]
    province.hst = p[:hst]
  end
end
puts "#{Province.count} provinces"

# 2. Categories & Products
products_data = []

uri = URI("https://dummyjson.com/products?limit=0")
response = Net::HTTP.get(uri)
data = JSON.parse(response)
products_data = data["products"]

products_data.each do |product|
  category = Category.find_or_create_by(name: product["category"].capitalize.gsub("-", " ")) do |c|
    c.description = "#{product["category"].capitalize.gsub("-", " ")} collection"
  end

  Product.find_or_create_by(name: product["title"]) do |p|
    p.category = category
    p.description = product["description"]
    p.price = product["price"]
    p.stock = product["stock"]
    p.image = product["thumbnail"]
  end
end

# 3. Users, Addresses, Orders
50.times do
  user = User.create!(
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )

  province = Province.all.sample

  address = Address.create!(
    user: user,
    province: province,
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    postal_code: "#{("A".."Z").to_a.sample}#{rand(0..9)}#{("A".."Z").to_a.sample} #{rand(0..9)}#{("A".."Z").to_a.sample}#{rand(0..9)}"
  )

  rand(1..3).times do
    order = Order.create!(
      user: user,
      address: address,
      province: province,
      status: [ "pending", "processing", "shipped", "delivered" ].sample,
      gst_rate: province.gst,
      pst_rate: province.pst,
      hst_rate: province.hst,
      total: 0,
      created_at: Faker::Time.between(from: 1.year.ago, to: Time.now)
    )

    total = 0
    rand(1..4).times do
      product = Product.all.sample
      quantity = rand(1..3)
      item_price = product.price

      OrderItem.create!(
        order: order,
        product: product,
        quantity: quantity,
        item_price: item_price
      )

      total += item_price * quantity
    end

    order.update!(total: total)
  end
end

puts "#{User.count} users"
puts "#{Address.count} addresses"
puts "#{Order.count} orders"
puts "#{OrderItem.count} order items"
puts "Complete."
