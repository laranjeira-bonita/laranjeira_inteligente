class PromotionService
  def initialize(promotion)
    @promotion = promotion
  end

  def add_ticker(user, reward, off_type = nil)
    @promotion&.tickers&.create(
      user: user,
      rate: reward,
      off_type: off_type || @promotion.off_type
    )
  end

  def get_result
    num = send("#{@promotion.activity.game_type}_calculation")
    save_promotion_result(num)
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

  def save_in_participation(winner, reward, position)
    winner.update_columns(
      reward_off_type: :pix,
      reward_rate: reward,
      reward_position: position
    )
  end

  def save_promotion_result(num)
    multi_rewards = @promotion.multi_rewards.sort.reverse
    winners = @promotion.participations.closest_to(num).first(multi_rewards.count)
    winners.each_with_index do |winner, i|
      add_ticker(winner, multi_rewards[i]) unless @promotion.pix?
      save_in_participation(winner, multi_rewards[i], i+1)
    end
    @promotion.update(
      target_number: num,
      status: :completed,
      multi_winner: winners.map(&:user_id)
    )
  end
end






