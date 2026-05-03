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

  def self_clone
    new_promo
  end

  private

  def new_promo
    Promotion.create(
      off_type: @promotion.off_type,
      rate: @promotion.rate,
      title: "#{Promotion.count + 1}º Jogo",
      activity_id: @promotion.activity_id,
      status: :pending,
      people_limit: @promotion.people_limit,
      multi_rewards: @promotion.multi_rewards
    ).tap do |promo|
      new_products(promo)
    end
  end

  def new_products(new_promotion)
    new_promotion.products = @promotion.products.map do |product|
      Product.create(
        name: product.name,
        category: product.category,
        price: product.price,
        multi_number: product.multi_number
      )
    end
  end

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






