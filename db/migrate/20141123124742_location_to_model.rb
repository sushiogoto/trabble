class LocationToModel < ActiveRecord::Migration
  def change
    Trip.all.each { |t| t.location = Location.create name: t.location }
    remove_column :trips, :location
  end
end
