class ParticipationsController < ApplicationController
  before_action :set_participation, only: %i[ show update ]

  def index
    @participations = current_user.participations.includes(:activity)
  end

  def show
  end


  def update
    respond_to do |format|
      if @participation.update(participation_params)
        format.html { redirect_to @participation, notice: "Participation was responded updated." }
        format.json { render :show, status: :ok, location: @participation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_participation
      @participation = Participation.find(params[:id])
    end
    def participation_params
      params.require(:participation).permit(:response)
    end 
end
