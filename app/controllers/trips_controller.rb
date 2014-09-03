class TripsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /trips
  # GET /trips.json
  def index
    #@trips = Trip.all
    @trips = Trip.paginate(:page => params[:page], :per_page => 12).order('id DESC')
    authorize Trip
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @participants = @trip.participants
  end

  # GET /trips/new
  def new
    @trip = Trip.new
    authorize @trip
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(trip_params)
    authorize @trip

    @trip.user_id = current_user.id
    @trip.authentication_token = Devise.friendly_token

    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
      authorize @trip
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:name, :notes, :dest_lat, :dest_long, :depart_at, :arrive_at, :start_at, :finish_at, :authentication_token, :pin, :user_id)
    end
end
