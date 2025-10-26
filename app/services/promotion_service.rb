class PromotionService
  def initialize(promotion)
    @promotion = promotion
  end

  def add_ticker(user)
    @promotion&.tickers&.create(
      user: user,
      rate: @promotion.product.price,
      off_type: :gift_card,
      store_id: @promotion.store_id
    )
  end
end