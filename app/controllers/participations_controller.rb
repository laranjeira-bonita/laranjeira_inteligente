class ParticipationsController < ApplicationController
  before_action :set_participation, only: %i[ update ]

  def index
    @participations = current_user.participations.includes(:activity)
  end

  def update
    if @participation.update(participation_params)
      redirect_to promotion_path(@participation.promotion)
    end
  end

  private
    def set_participation
      @participation = current_user.participations.find_by(id: params[:id])
      if @participation.nil?
        redirect_to products_path
      end
    end
    def participation_params
      params.require(:participation).permit(:response, :nickname)
    end 
end
