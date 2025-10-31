class PromotionService
  def initialize(promotion)
    @promotion = promotion
  end

  def add_ticker(user, off_rate, off_type)
    @promotion&.tickers&.create(
      user: user,
      rate: off_rate,
      off_type: off_type,
      store_id: @promotion.store_id
    )
  end

  def get_result
    num = send("#{@promotion.activity.game_type}_calculation")
    winner = @promotion.participations.closest_to(num).first.user
    save_promotion_result(num, winner)
  rescue NoMethodError => e
    Rails.logger.error("Error retrieving result: #{e.message}")
    nil
  end

  private

  def mean_calculation
    responses = @promotion.participations.pluck(:response).compact
    responses.sum / [responses.size, 1].max.to_f
  end

  def median_calculation
    responses = @promotion.participations.pluck(:response).compact.sort
    return responses[responses.size / 2] if responses.size.odd?
    (responses[responses.size / 2 - 1] + responses[responses.size / 2]) / 2.0
  end

  def save_promotion_result(num, winner)
    add_ticker(winner, @promotion.rate, @promotion.off_type)
    @promotion.update(
      target_number: num,
      winner: winner,
      status: :completed
    )
  end
end






