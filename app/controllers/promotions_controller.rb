class PromotionsController < ApplicationController
  before_action :set_promotion, only: :show

  def index
    @promotions = Promotion.all
  end

  def show
    add_invitation_bonus if Rails.env.development?
  end

  private
    def set_promotion
      @promotion = Promotion.find(params[:id])
    rescue
      @promotion = Promotion.active_one
    end

    def promotion_params
      params.require(:promotion).permit(:rate, :category)
    end

    def add_invitation_bonus
      invite_code = cookies[:invite_code]
      return unless invite_code.present?

      inviter = User.find_by(uuid: invite_code)
      return unless inviter.present? && inviter != current_user

      PromotionService.new(@promotion).add_ticker(inviter, 1, :invitation)
      cookies.delete(:invite_code)
    end
end
