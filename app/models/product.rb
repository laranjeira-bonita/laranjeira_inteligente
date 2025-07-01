class Product < ApplicationRecord
    belongs_to :store
    belongs_to :promotion, optional: true
    has_many :descriptions, as: :describable, dependent: :destroy
end
