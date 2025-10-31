class Promotion < ApplicationRecord
    belongs_to :activity
    belongs_to :store
    belongs_to :winner, class_name: 'User', optional: true
    has_many :descriptions, as: :describable, dependent: :destroy
    has_many :tickers, dependent: :destroy
    has_many :participations, dependent: :destroy
    enum off_type: { gift_card: 0, discount: 1 }
    enum status: { pending: 0, achieved_limit: 1, completed: 2 }
end
