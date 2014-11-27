class TripMailer < ActionMailer::Base
  default from: "traveller@trabble.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.trip_mailer.data_update_notification.subject
  #
  def data_update_notification(user, model, trip_id)
    trip = Trip.find_by(id: trip_id)
    trip_users = trip.users
    trip_locations = trip.locations
    trip_accomodations = trip.accomodations
    trip_transportations = trip.transportations
    trip_name = trip.name
    @model = model
    if model == "location"
      @details = trip_locations.map { |location| location.name }.join(", ")
    elsif model == "transportation"
      @details = trip_transportations.map { |transportation| transportation.url }.join(", ")
    elsif model == "accomodation"
      @details = trip_accomodations.map { |accomodation| accomodation.url }.join(", ")
    else
      @details = ""
    end

    trip_users.each do |user|
      @user = user.email
      mail to: user.email
    end
  end
end
