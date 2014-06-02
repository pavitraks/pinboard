class PinsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_pin, only: [:show, :edit, :update, :destroy]

  # GET /pins
  # GET /pins.json
  def index
    @pins = Pin.order('created_at').page(params[:page])
  end

  # GET /pins/1
  # GET /pins/1.json
  def show
  end

  # GET /pins/new
  def new
    @pin = Pin.new
  end

  # GET /pins/1/edit
  def edit
  end

  # POST /pins
  # POST /pins.json
  def create
    @pin = Pin.new(pin_params)

    respond_to do |format|
      if @pin.save
        format.html { redirect_to @pin, notice: 'Pin was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pin }
      else
        format.html { render action: 'new' }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  def pin_post
    @current_pin = Pin.friendly.find(params[:id])
    @pin = @current_pin.repin_post(params[:board_id])
    respond_to do |format|
      if @pin.save
        format.js{render :layout => false}
      else
        format.js
      end
    end
  end

  def pins_newsletter

  end

  # PATCH/PUT /pins/1
  # PATCH/PUT /pins/1.json
  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html { redirect_to @pin, notice: 'Pin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pins/1
  # DELETE /pins/1.json
  def destroy
    @pin.destroy
    respond_to do |format|
      format.html { redirect_to pins_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find_by_slug(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:name, :image, :slug, :image_cache, :board_id)
    end
end
