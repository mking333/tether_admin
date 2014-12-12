json.array!(@trips) do |trip|
  json.extract! trip, :id, :name, :location, :notes, :dest_lat, :dest_long, :depart_at, :arrive_at, :start_at, :finish_at, :authentication_token, :pin, :user_id
  json.url trip_url(trip, format: :json)
end
