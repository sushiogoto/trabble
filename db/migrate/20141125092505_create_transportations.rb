class CreateTransportations < ActiveRecord::Migration
  def change
    create_table :transportations do |t|
      t.string :url
      t.date :departure_date
      t.date :return_date
      t.integer :price
      t.references :trip, index: true

      t.timestamps
    end
  end
end
