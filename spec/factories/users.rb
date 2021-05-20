FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {'test@test.com'}
    password              {'test0000'}
    password_confirmation {password}
    gimei = Gimei.name
    last_name             {gimei.last.kanji}
    first_name            {gimei.first.kanji}
    last_name_kana        {gimei.last.katakana}
    first_name_kana       {gimei.first.katakana}
    birthday              {Faker::Date.birthday(min_age: 5, max_age: 90)}
  end
end