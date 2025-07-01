class Ticker < ApplicationRecord
    belongs_to :promotion
    belongs_to :user
    has_many :descriptions, through: :promotion
    has_one :activity, through: :promotion
end
