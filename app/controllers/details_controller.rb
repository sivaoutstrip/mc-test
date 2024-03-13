class DetailsController < ApplicationController
  before_action :set_person
  before_action :set_detail, only: %i[show edit update destroy]

  # GET /details or /details.json
  def index
    @details = @person.details
  end

  # GET /details/1 or /details/1.json
  def show; end

  # GET /details/new
  def new
    @detail = Detail.new
  end

  # GET /details/1/edit
  def edit; end

  # POST /details or /details.json
  def create
    @detail = @person.details.new(detail_params)

    respond_to do |format|
      if @detail.save
        format.html { redirect_to person_url(@person), notice: 'Detail was successfully created.' }
        format.json { render :show, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /details/1 or /details/1.json
  def update
    respond_to do |format|
      if @detail.update(detail_params)
        format.html { redirect_to person_url(@person), notice: 'Detail was successfully updated.' }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /details/1 or /details/1.json
  def destroy
    @detail.destroy!

    respond_to do |format|
      format.html { redirect_to person_url(@person), alert: 'Detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find_by(id: params[:person_id])
    return @person unless @person.nil?

    respond_to do |format|
      format.html { redirect_to people_url, alert: 'Person not found.' }
      format.json { head :no_content }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_detail
    @detail = @person.details.find_by(id: params[:id])
    return @detail unless @detail.nil?

    respond_to do |format|
      format.html { redirect_to people_url, alert: 'Detail not found.' }
      format.json { head :no_content }
    end
  end

  # Only allow a list of trusted parameters through.
  def detail_params
    params.require(:detail).permit(:id, :email, :phone)
  end
end
