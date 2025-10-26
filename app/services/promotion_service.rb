class PromotionService
  def initialize(promotion)
    @promotion = promotion
  end

  def add_ticker(user, price)
    @promotion&.tickers&.create(
      user: user,
      rate: price,
      off_type: :gift_card,
      store_id: @promotion.store_id
    )
  end
end