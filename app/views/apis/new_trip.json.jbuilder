json.trip do
    json.result @result
    json.trip_id @new_trip.id
    json.name @new_trip.name
    json.token @new_trip.authentication_token
    json.pin @new_trip.pin
    json.user @new_trip.user.name ? @new_trip.user.name : @new_trip.user.email
    json.notes @new_trip.notes
    json.dest_lat @new_trip.dest_lat
    json.dest_long @new_trip.dest_long
    json.depart @new_trip.depart_at ? @new_trip.depart_at.iso8601 : ""
    json.arrive @new_trip.arrive_at ? @new_trip.arrive_at.iso8601 : ""
    json.start @new_trip.start_at ? @new_trip.start_at.iso8601 : ""
    json.finish @new_trip.finish_at ? @new_trip.finish_at.iso8601 : ""
end