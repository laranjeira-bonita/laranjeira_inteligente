class PromotionJob < ApplicationJob
  queue_as :default

  def perform(promotion_id)
    promotion = Promotion.find(promotion_id)
    PromotionService.new(promotion).get_result
  end
end
