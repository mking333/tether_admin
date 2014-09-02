class ApisController < ApplicationController
  # GET /apis
  # GET /apis.json
  def login
    #user_id = params[:id]
    user_email = params[:user_email]
    user_password = params[:user_password]

    user = User.find_by_email(user_email)
    if user && user.valid_password?(user_password)
      @email = user.email
      @token = user.authentication_token
      @result = "success"
    else
      @email = params[:user_email]
      @token = ""
      @result = "not found"
    end
  end

  def join
    #trip_token = params[:token]
    user_email = params[:email]
    trip_pin = params[:pin]
    user_name = params[:name]

    #@trip = Trip.find_by_id_and_authentication_token(params[:id], trip_token)
    @trip = Trip.where(["id = ? and pin = ?", params[:id], trip_pin]).order("name").first
    if @trip
      @participant = Participant.where(["trip_id = ? and email = ?", @trip.id, user_email]).order("name").first
      if @participant.nil?
        @participant = Participant.new
        @participant.trip_id = params[:id]
        @participant.pin = rand(1000..9999)
        @participant.email = user_email
        @participant.leader = false
      end
      @participant.name = user_name
      @participant.join_at = DateTime.now
      @participant.quit_at = nil
      @participant.save
      if @participant.leader? # && @trip.start_at.nil?
        @trip.start_at = DateTime.now
        @trip.finish_at = nil
        @trip.save
      end

      @participants = Participant.where(["trip_id = ?", @trip.id]).order("name").load

      @result = "success"
      render
    else
      @result = "trip not found"
      render :join_error
    end
  end

  def quit
    trip_token = params[:token]
    user_email = params[:email]
    user_pin = params[:pin]

    #@trip = Trip.find_by_id_and_authentication_token(params[:id], trip_token)
    @trip = Trip.where(["id = ? and authentication_token = ?", params[:id], trip_token]).order("name").first
    if @trip
      @participant = Participant.where(["trip_id = ? and email = ? and pin = ?", @trip.id, user_email, user_pin]).order("name").first
      if @participant
        @participant.quit_at = DateTime.now
        @participant.save
        if @participant.leader?
          @trip.finish_at = DateTime.now
          @trip.save
        end
        @result = "success"
        render
      else
        @result = "participant not found"
        render :quit_error
      end
    else
      @result = "trip not found"
      render :quit_error
    end
  end

  def checkin
    trip_token = params[:token]
    user_email = params[:email]
    user_pin = params[:pin]
    lat = params[:lat]
    long = params[:long]
    status = params[:status]

    @trip = Trip.where(["id = ? and authentication_token = ?", params[:id], trip_token]).order("name").first
    if @trip
      @participant = Participant.where(["trip_id = ? and email = ? and pin = ?", @trip.id, user_email, user_pin]).order("name").first
      if @participant
        @participant.current_lat = lat
        @participant.current_long = long
        @participant.checkin_at = DateTime.now
        #if status != ''
          @participant.status = status
        #end
        @participant.save
        @participants = Participant.where(["trip_id = ?", @trip.id]).order("updated_at").load
        @result = "success"
        render
      else
        @result = "participant not found"
        render :checkin_error
      end
    else
      @result = "trip not found"
      render :checkin_error
    end
  end

  def mapping
    trip_token = params[:token]
    user_email = params[:email]
    user_pin = params[:pin]
    @selected_name = params[:name]

    @trip = Trip.where(["id = ? and authentication_token = ?", params[:id], trip_token]).order("name").first
    if @trip
      @result = "success"
      @participant = Participant.where(["trip_id = ? and email = ? and pin = ?", @trip.id, user_email, user_pin]).order("name").first
      if @participant
        if @selected_name
          @participants = Participant.where(["trip_id = ? and name = ?", @trip.id, @selected_name]).order("updated_at").load
        else
          @participants = Participant.where(["trip_id = ?", @trip.id]).order("updated_at").load
        end
        @result = "success"
        render
      else
        @result = "participant not found"
        render :mapping_error
      end
    else
      @result = "trip not found"
      render :mapping_error
    end
  end

  # params: email & name & pw
  # renders: json with result, user.id, user.email, user.authentication_token
  def sign_in
    user_email = params[:email]
    user_password = params[:pw]
    user_name = params[:name]

    @user = User.where(["email = ? and confirmed_at is not null", user_email]).first
    if @user
      if @user.valid_password?(user_password)
        @user.name = user_name
	@user.authentication_token ||= Devise.friendly_token
        @user.save

        @result = "success"
        render
      else
        @result = "password error"
        render :sign_in_error
      end
    else
      @result = "user not found"
      render :sign_in_error
    end
  end

  # params: email & name & pw & pw_confirmation
  # renders: json with result, user.id, user.email, user.authentication_token
  def sign_up
    user_email = params[:email]
    user_password = params[:pw]
    user_confirmation = params[:confirm]
    user_name = params[:name]

    @user = User.where(["email = ?", user_email]).first
    if @user
      @result = "duplicate user"
      render :sign_up_error
    else
      if user_password.length < 8 || user_password != user_confirmation
        @result = "password error"
        render :sign_up_error
      else
        @user = User.new
        @user.email = user_email
        @user.name = user_name
        @user.password = user_password
        @user.password_confirmation = user_confirmation
        @user.save

        @result = "success"
        render
      end
    end
  end

  # params: user.id, user.email, user.authentication_token, name, city, notes, lat, long, depart, arrive
  # renders: result, trip.id, trip.authentication_token
  def new_trip
    user_email = params[:email]
    user_token = params[:token]

    trip_name = params[:name]
    trip_location = params[:location]
    trip_notes = params[:notes]
    trip_lat = params[:lat]
    trip_long = params[:long]
    trip_depart = params[:depart]
    trip_arrive = params[:arrive]

    @user = User.find(params[:id])
    if @user
      if @user.email == user_email && @user.authentication_token == user_token
        @new_trip = Trip.new
        ' set the user id, hope it works '
        @new_trip.user_id = @user.id
        @new_trip.name = trip_name
        @new_trip.notes = trip_notes
        @new_trip.dest_lat = trip_lat
        @new_trip.dest_long = trip_long
        @new_trip.depart_at = trip_depart
        @new_trip.arrive_at = trip_arrive
        @new_trip.authentication_token = Devise.friendly_token
        @new_trip.pin = rand(1000000..9999999)
        @new_trip.save

        @result = "success"
        render
      else
        @result = "password error"
        render :new_trip_error
      end
    else
      @result = "user not found"
      render :new_trip_error
    end
  end

  # params: user.email, trip.id, trip.authentication_token - see checkin
  # renders: result, participant.name, participant.email
  def add_part
    trip_token = params[:token]

    participant_name = params[:name]
    participant_email = params[:email]
    participant_leader = params[:leader]

    #@trip = Trip.find_by_id_and_authentication_token(params[:id], trip_token)
    @trip = Trip.where(["id = ?", params[:id]]).order("name").first
    if @trip
      if @trip.authentication_token == trip_token
        @participant = Participant.where(:trip_id => @trip.id, :email => participant_email).first_or_create
        @participant.trip_id = @trip.id
        @participant.name = participant_name
        @participant.email = participant_email
        @participant.leader = participant_leader == 'yes' ? true : false
        @participant.pin = rand(1000..9999)
        @participant.save

        UserMailer.trip_invite_email(@participant).deliver

        @result = "success"
        render
      else
        @result = "password error"
        render :add_part_error
      end
    else
      @result = "trip not found"
      render :add_part_error
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def api_params
      params.require(:api).permit(:id, :user_email, :user_password, :user_pin, :lat, :long, :status)
    end
end
