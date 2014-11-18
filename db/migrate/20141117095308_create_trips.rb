class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :location
      t.string :owner
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
