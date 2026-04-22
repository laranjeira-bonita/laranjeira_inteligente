class PurchasesController < ApplicationController
  before_action :set_payment, only: %i[ confirm_payment ]

  def index
    @purchases = current_user.purchases.includes(:product)
  end

  def confirm_payment
    approved = Rails.env.development? || PurchaseService.new.confirm_payment(@payment)
    add_invitation_bonus if approved
    redirect_to @payment.promotion
  end

  private
    def set_payment
      @payment = Payment.find(params[:payment_id])
    end

    def add_invitation_bonus
      invite_code = cookies[:invite_code]
      return unless invite_code.present?

      inviter = User.find_by(uuid: invite_code)
      return unless inviter.present? && inviter != user

      PromotionService.new(promotion).add_ticker(inviter, 1, :invitation)
      cookies.delete(:invite_code)
    end
end
