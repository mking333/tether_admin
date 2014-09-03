json.array!(@participants) do |participant|
  json.extract! participant, :id, :email, :pin, :name, :leader, :current_lat, :current_long, :depart_at, :arrive_at, :join_at, :quit_at, :checkin_at, :trip_id, :status
  json.url participant_url(participant, format: :json)
end
