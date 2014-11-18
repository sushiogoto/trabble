class CreateTripUsers < ActiveRecord::Migration
  def change
    create_table :trip_users do |t|
      t.belongs_to :user
      t.belongs_to :trip

      t.timestamps
    end
  end
end
