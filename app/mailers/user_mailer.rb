class UserMailer < ActionMailer::Base
  default from: "triptether@gmail.com"

  def trip_invite_email(participant)
    @participant = participant
    mail(to: @participant.email, subject: 'You have been invited on a trip with TripTether!')
  end
end
