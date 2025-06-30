class DescriptionsController < ApplicationController
  before_action :set_description, only: %i[ show edit update destroy ]

  # GET /descriptions or /descriptions.json
  def index
    @descriptions = Description.all
  end

  # GET /descriptions/1 or /descriptions/1.json
  def show
  end

  # GET /descriptions/new
  def new
    @description = Description.new
  end

  # GET /descriptions/1/edit
  def edit
  end

  # POST /descriptions or /descriptions.json
  def create
    @description = Description.new(description_params)

    respond_to do |format|
      if @description.save
        format.html { redirect_to @description, notice: "Description was successfully created." }
        format.json { render :show, status: :created, location: @description }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @description.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /descriptions/1 or /descriptions/1.json
  def update
    respond_to do |format|
      if @description.update(description_params)
        format.html { redirect_to @description, notice: "Description was successfully updated." }
        format.json { render :show, status: :ok, location: @description }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @description.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /descriptions/1 or /descriptions/1.json
  def destroy
    @description.destroy!

    respond_to do |format|
      format.html { redirect_to descriptions_path, status: :see_other, notice: "Description was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_description
      @description = Description.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def description_params
      params.fetch(:description, {})
    end
end
