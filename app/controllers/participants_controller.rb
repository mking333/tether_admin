class ParticipantsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized

  # GET /participants
  # GET /participants.json
  def index
    #@participants = Participant.all
    @participants = Participant.paginate(:page => params[:page], :per_page => 12).order('id DESC')
    @trip_count = Participant.distinct.count('trip_id')
    authorize Participant
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
    authorize @participant
  end

  # GET /participants/1/edit
  def edit
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new(participant_params)
    authorize @participant

    @participant.pin = rand(1000..9999)

    respond_to do |format|
      if @participant.save
        format.html { redirect_to @participant, notice: 'Participant was successfully created.' }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { render :new }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.json { render :show, status: :ok, location: @participant }
      else
        format.html { render :edit }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_url, notice: 'Participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
      authorize @participant
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      params.require(:participant).permit(:email, :pin, :name, :leader, :current_lat, :current_long, :depart_at, :arrive_at, :join_at, :quit_at, :checkin_at, :status, :trip_id)
    end
end
