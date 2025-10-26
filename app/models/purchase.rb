class Purchase < ApplicationRecord
  has_many :payments
  belongs_to :user
  belongs_to :product
  enum state: { added: 0, paid: 1, deliverred: 2, canceled: 3 }
end
