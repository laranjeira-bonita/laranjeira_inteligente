class ProductPurchase < ApplicationRecord
    belongs_to :product
    belongs_to :purchase
    belongs_to :ticker, optional: true
end
