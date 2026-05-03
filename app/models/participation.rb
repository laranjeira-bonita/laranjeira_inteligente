class Participation < ApplicationRecord
  belongs_to :promotion
  belongs_to :user
  before_create :validate_promo_status
  after_create :check_promotion_completion

  scope :closest_to, ->(n) {
    order(Arel.sql("ABS(response - #{n}), created_at ASC"))
  }

  scope :responded, -> {
    where.not(response: nil)
  }

  scope :from_user_id, ->(user_id) {
    where(user_id: user_id)
  }

  def check_promotion_completion
    return unless promotion.people_limit.present?
    return unless promotion.participations.count >= promotion.people_limit
    create_new_promo
    promotion.update(status: :achieved_limit)
    PromotionJob.set(wait: 1.hours).perform_later(promotion.id)
  end

  def create_new_promo
    PromotionService.new(promotion).self_clone
  end

  def validate_promo_status
    unless promotion.pending?
      self.promotion_id = Promotion.active_one&.id
    end
  end
end
