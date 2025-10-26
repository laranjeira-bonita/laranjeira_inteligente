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

  def get_result
    get_result_method = "get_#{@promotion.activity.game_type}_result"
    send(get_result_method)
  rescue NoMethodError => e
    Rails.logger.error("Error retrieving result: #{e.message}")
    nil
  end

  def get_medium_number_result
    responses = @promotion.participations.map(&:response)
    responses.sum / [responses.size.to_f, 1].max
  end
end






