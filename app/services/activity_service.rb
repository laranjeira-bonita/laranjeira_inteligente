class ActivityService
  def initialize(activity)
    @activity = activity
  end

  def get_result
    get_method = "get_#{@activity.game_type}_result"
    send(get_method)
  rescue NoMethodError => e
    Rails.logger.error("Error retrieving result: #{e.message}")
    nil
  end

  private
  def get_medium_number_result
    responses = @activity.participations.map(&:response)
    responses.sum / [responses.size.to_f, 1].max
  end
end