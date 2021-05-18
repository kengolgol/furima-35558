# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# テーブル設計

## Users テーブル

| Column                  | Type   | Option                    |
|-------------------------|--------|---------------------------|
| nickname                | string | null: false               |
| last_name               | string | null: false               |
| first_name              | string | null: false               |
| last_name_kana          | string | null: false               |
| first_name_kana         | string | null: false               |
| email                   | string | null: false, unique: true |
| encrypted_password      | string | null: false               |
| birthday                | date   | null: false               |

### Association
- has_many :items
- has_many :buys


## Items テーブル

| Column             | Type       | Option             |
|--------------------|------------|--------------------|
| name               | string     | null: false        |
| content            | text       | null: false        |
| category_id        | integer    | null: false        |
| condition_id       | integer    | null: false        |
| delivery_charge_id | integer    | null: false        |
| area_id            | integer    | null: false        |
| day_to_ship_id     | integer    | null: false        |
| price              | integer    | null: false        |
| user               | references | foreign_keys: true |

### Association
- belongs_to :user
- has_one :buy


## Buys テーブル

| Column | Type       | Option             |
|--------|------------|--------------------|
| user   | references | foreign_keys: true |
| item   | references | foreign_keys: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :area


## Areas テーブル
| Column      | Type       | Option             |
|-------------|------------|--------------------|
| postal_code | string     | null: false        |
| area_id     | integer    | null: false        |
| town        | string     | null: false        |
| address     | string     | null: false        |
| building    | string     |                    |
| tel         | string     | null: false        |
| buy         | references | foreign_keys: true |

### Association
- belongs_to :buy

