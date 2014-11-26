class AddTripIdToTransportation < ActiveRecord::Migration
  def change
    add_column :transportations, :trip_id, :integer
    add_index :transportations, :trip_id
  end
end
