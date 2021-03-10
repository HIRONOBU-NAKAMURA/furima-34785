# テーブル設計

## users テーブル

| Column     | Type   | Option      |
| ---------- | ------ | ----------- |
| nickname   | string | null: false |
| email      | string | null: false |
| password   | string | null: false |
| last_name  | string | null: false |
| first_name | string | null: false |
| birthday   | string | null: false |

### Association

- has_many :items
- has_many :purchase_record

## items テーブル

| Column           | Type       | Option                         |
| ---------------- | ---------- | ------------------------------ |
| title            | string     | null: false                    |
| description      | text       | null: false                    |
| category         | string     | null: false                    |
| status           | string     | null: false                    |
| shipping_change  | string     | null: false                    |
| shipping_address | string     | null: false                    |
| day              | string     | null: false                    |
| price            | integer    | null: false                    |
| user             | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_many :purchase_record

## purchase_record テーブル

| Column | Type       | Option                         |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key:true  |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_address テーブル

| Column          | Type       | Option                         |
| --------------- | ---------- | ------------------------------ |
| postal_code     | integer    | null: false                    |
| prefecture      | string     | null: false                    |
| city            | string     | null: false                    |
| address         | string     | null: false                    |
| building_name   | string     |                                |
| phone_number    | integer    | null: false                    |
| purchase_record | references | null: false, foreign_key: true |

### Association

- belongs_to :purchase_record
