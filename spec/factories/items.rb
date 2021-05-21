FactoryBot.define do
  factory :item do
    name               {Faker::Name.name}
    content            {Faker::Lorem.sentence}
    category_id        {Faker::Number.between(from: 2, to: 11)}
    condition_id       {Faker::Number.between(from: 2, to: 7)}
    delivery_charge_id {Faker::Number.between(from: 2, to: 3)}
    area_id            {Faker::Number.between(from: 2, to: 48)}
    day_to_ship_id     {Faker::Number.between(from: 2, to: 4)}
    price              {Faker::Number.number(digits: 5)}
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test.png'), filename: 'test.png')
    end
  end
end
