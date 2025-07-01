class Activity < ApplicationRecord
    has_many :promotions, dependent: :destroy
    has_many :tickers, through: :promotions
end
