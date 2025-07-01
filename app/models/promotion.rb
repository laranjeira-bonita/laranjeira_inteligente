class Promotion < ApplicationRecord
    belongs_to :activity
    belongs_to :store
    has_many :descriptions, as: :describable, dependent: :destroy
    has_many :tickers, dependent: :destroy
end
