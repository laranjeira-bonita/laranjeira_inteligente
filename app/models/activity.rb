class Activity < ApplicationRecord
    enum game_type: { mean: 0, median: 1 }
    belongs_to :winner, class_name: "User", optional: true
    has_many :descriptions, as: :describable, dependent: :destroy
    has_many :users, through: :activities_users
    has_many :promotions, dependent: :destroy
    has_many :tickers, through: :promotions
end
