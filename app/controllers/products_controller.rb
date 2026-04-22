class ProductsController < ApplicationController
  before_action :set_product, only: %i[ purge_image buy]
  before_action :set_promotion, only: %i[ select_quantity ]
  before_action :render_to_register, only: %i[ buy ]
  before_action :save_invite_code, only: %i[ index ]
  def index
    @products = Product.where(category: 'electronics')
  end

  def purge_image
    image = @product.images.find(params[:image_id])
    image.purge
    redirect_back fallback_location: edit_product_path(@product), notice: "Image deleted."
  end

  def select_quantity
    @products = @promotion.products
  end

  def buy
    @payment = PurchaseService.new.create(@product, current_user)
    if Rails.env.development?
      redirect_to promotion_path(@product.promotion)
    else
      respond_to do |format|
        format.html do
          html = render_to_string(
            partial: "pix_code",
            locals: { transaction: @payment.transaction_record, payment_id: @payment.id, purchase: @payment.purchase }
          )
          render html: html.html_safe
        end
      end
    end
  end

  private
    def save_invite_code
      if params[:invite_code].present?
        cookies[:invite_code] = {
          value: params[:invite_code],
          expires: 7.days.from_now
        }
      end
    end

    def set_promotion
      @promotion = Promotion.find(params[:promotion_id])
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def render_to_register
      unless user_signed_in?
        store_location_for :user, select_quantity_path(@product.promotion)
        redirect_to new_user_session_path
      end
    end
end
