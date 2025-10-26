class Payment < ApplicationRecord
  include AASM

  belongs_to :purchase
  has_one :user, through: :purchase
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :payment_method, presence: true
  validates :status, presence: true, inclusion: { in: %w[opened paid cancelled] }
  validates :transaction_id, presence: true, uniqueness: true

  aasm column: :status do
    state :opened, initial: true
    state :paid
    state :cancelled

    event :pay do
      transitions from: :opened, to: :paid, after: [:add_bonus_activity, :add_ticker]
    end

    event :cancel do
      transitions from: [:opened, :paid], to: :cancelled
    end
  end

  def product
    purchase.product
  end

  def promotion
    product.promotion
  end

  def add_ticker
    return unless valid_gift_card?
    PromotionService.new(promotion).add_ticker(user)
  end

  def add_bonus_activity
    return unless valid_gift_card?
    promotion&.activity&.participations&.create(user: user)
  end

  def has_activity?
    promotion&.activity&.participations&.exists?(user: user)
  end

  def valid_gift_card?
    product.gift_card?
  end
end
