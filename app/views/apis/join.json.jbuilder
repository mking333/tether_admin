json.trip do
    json.result @result
    json.trip_id @trip.id
    json.name @trip.name
    json.location @trip.location
    json.token @trip.authentication_token
    json.user @trip.user ? @trip.user.name : ""
    json.notes @trip.notes
    json.dest_lat @trip.dest_lat
    json.dest_long @trip.dest_long
    json.depart @trip.depart_at ? @trip.depart_at.iso8601 : ""
    json.arrive @trip.arrive_at ? @trip.arrive_at.iso8601 : ""
    json.start @trip.start_at ? @trip.start_at.iso8601 : ""
    json.finish @trip.finish_at ? @trip.finish_at.iso8601 : ""
    json.participant do
        json.participant_id @participant.id
        json.name @participant.name
        json.email @participant.email
        json.pin @participant.pin
        json.curr_lat @participant.current_lat
        json.curr_long @participant.current_long
        json.status @participant.status
        json.checkin @participant.checkin_at ? @participant.checkin_at.iso8601 : ""
        json.leader @participant.leader ? "yes" : "no"
        json.join @participant.join_at ? @participant.join_at.iso8601 : ""
        json.quit @participant.quit_at ? @participant.quit_at.iso8601 : ""
    end
end