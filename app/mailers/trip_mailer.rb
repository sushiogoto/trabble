class TripMailer < ActionMailer::Base
  default from: "traveller@trabble.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.trip_mailer.data_update_notification.subject
  #
  def data_update_notification(user, deets)
    @trip = user.trips.first.name

    if deets.is_a? Location
      @details = deets.name
    else
      @details = deets.url
    end


    mail to: user.email
  end
end
