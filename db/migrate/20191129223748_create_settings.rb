class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.string :service_url, null: false, default: ''

      t.timestamps
    end
  end
end
