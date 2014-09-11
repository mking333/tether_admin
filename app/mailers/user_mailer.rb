class UserMailer < ActionMailer::Base
  default from: "triptether@gmail.com"

  def trip_invite_email(participant)
    @participant = participant
    mail(to: @participant.email, subject: 'TripTether New Trip!')
  end
end
