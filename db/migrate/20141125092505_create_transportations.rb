class CreateTransportations < ActiveRecord::Migration
  def change
    create_table :transportations do |t|
      t.string :URL
      t.date :Departure_date
      t.date :Return_date
      t.integer :Price

      t.timestamps
    end
  end
end
