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

| Column        | Type   | Option                    |
|---------------|--------|---------------------------|
| nickname      | string | null: false               |
| kana_nickname | string | null: false               |
| email         | string | null: false, unique: true |
| password      | string | null: false               |
| birthday      | date   | null: false               |

### Association
- has_many :items
- has_many :buys


## Items テーブル

| Column          | Type       | Option             |
|-----------------|------------|--------------------|
| name            | string     | null: false        |
| content         | text       | null: false        |
| category        | string     | null: false        |
| condition       | text       | null: false        |
| delivery_charge | enum       | null: false        |
| area            | enum       | null: false        |
| days_to_ship    | enum       | null: false        |
| price           | integer    | null: false        |
| user_id         | references | foreign_keys: true |

### Association
- belongs_to :user
- has_one :buy


## Buys テーブル

| Column  | Type       | Option             |
|---------|------------|--------------------|
| user_id | references | foreign_keys: true |
| item_id | references | foreign_keys: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :buy


## Area テーブル
| Column      | Type       | Option             |
|-------------|------------|--------------------|
| postal_code | integer    | null: false        |
| state       | string     | null: false        |
| town        | string     | null: false        |
| address     | string     | null: false        |
| building    | string     |                    |
| user_id     | references | foreign_keys: true |

### Association
- belongs_to :buy

