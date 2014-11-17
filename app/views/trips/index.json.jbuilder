json.array!(@trips) do |trip|
  json.extract! trip, :id, :location, :start_date, :end_date
  json.url trip_url(trip, format: :json)
end
