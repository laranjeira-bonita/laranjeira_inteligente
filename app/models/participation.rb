class Participation < ApplicationRecord
  belongs_to :promotion
  belongs_to :user
  after_create :check_promotion_completion

  scope :closest_to, ->(n) {
    order(Arel.sql("ABS(response - #{n}), created_at ASC"))
  }

  def check_promotion_completion
    return unless promotion.people_limit.present?
    return unless promotion.participations.count >= promotion.people_limit
    promotion.update(status: :achieved_limit)
    PromotionJob.set(wait: 1.hours).perform_later(promotion.id)
  end
end
