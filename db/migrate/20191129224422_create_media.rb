class CreateMedia < ActiveRecord::Migration[6.0]
  def change
    create_table :media do |t|
      t.string :name
      t.integer :times_per_hour

      t.references :device

      t.timestamps
    end
  end
end
