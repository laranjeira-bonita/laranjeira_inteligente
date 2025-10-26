class Ticker < ApplicationRecord
    belongs_to :promotion
    belongs_to :user
    has_many :descriptions, through: :promotion
    has_one :activity, through: :promotion
    enum off_type: { gift_card: 0, disccount: 1 }
end
