class CreateAccomodations < ActiveRecord::Migration
  def change
    create_table :accomodations do |t|
      t.string :url
      t.date :check_in
      t.date :check_out
      t.integer :price
      t.integer :trip_id

      t.timestamps
    end
    add_index :accomodations, :trip_id
  end
end
