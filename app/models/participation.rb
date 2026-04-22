class Participation < ApplicationRecord
  belongs_to :promotion
  belongs_to :user
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
    return unless promotion.participations.where('response is not null').count >= promotion.people_limit
    promotion.update(status: :achieved_limit)
    PromotionJob.set(wait: 1.hours).perform_later(promotion.id)
  end
end
