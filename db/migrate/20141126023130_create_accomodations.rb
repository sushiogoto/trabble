class CreateAccomodations < ActiveRecord::Migration
  def change
    create_table :accomodations do |t|
      t.string :url
      t.date :check_in
      t.date :check_out
      t.integer :price
      t.references :trip, index: true

      t.timestamps
    end
  end
end
