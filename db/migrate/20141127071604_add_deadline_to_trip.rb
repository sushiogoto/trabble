class AddDeadlineToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :deadline_accomodations, :datetime
    add_column :trips, :deadline_locations, :datetime
    add_column :trips, :deadline_transportations, :datetime
  end
end
