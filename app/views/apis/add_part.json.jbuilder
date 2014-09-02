json.participant do
    json.result @result
    json.participant_id @participant.id
    json.name @participant.name
    json.email @participant.email
    json.curr_lat @participant.current_lat
    json.curr_long @participant.current_long
    json.status @participant.status
    json.checkin @participant.checkin_at ? @participant.checkin_at.iso8601 : ""
    json.leader @participant.leader ? "yes" : "no"
    json.join @participant.join_at ? @participant.join_at.iso8601 : ""
    json.quit @participant.quit_at ? @participant.quit_at.iso8601 : ""
end