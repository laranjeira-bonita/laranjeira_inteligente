class Product < ApplicationRecord
    belongs_to :store
    belongs_to :promotion, optional: true
    has_many :descriptions, as: :describable, dependent: :destroy
    enum category: { gift_card: 0, electronics: 1 }
    has_many_attached :images
end
