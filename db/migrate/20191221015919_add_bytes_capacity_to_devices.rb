class AddBytesCapacityToDevices < ActiveRecord::Migration[6.0]
  def change
    add_column :devices, :bytes_capacity, :bigint, null: false, default: 0
  end
end
