FactoryBot.define do
  factory :buy_area do
    postal_code {"123-4567"}
    shipping_area_id {Faker::Number.between(from: 2, to: 48)}
    town {"〇〇市"}
    address {"〇〇町１−１"}
    tel {"09012345678"}
    building {"〇〇ハイツ"}
    token {"tok_abcdefghijk00000000000000000"}
  end
end