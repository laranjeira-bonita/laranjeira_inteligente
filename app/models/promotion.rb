class Promotion < ApplicationRecord
    belongs_to :activity
    belongs_to :store
    has_many :descriptions, as: :describable, dependent: :destroy
    has_many :tickers, dependent: :destroy
    enum off_type: { gift_card: 0, disccount: 1 }
end
