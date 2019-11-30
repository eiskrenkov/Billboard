class AddDebugToSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :settings, :debug, :boolean, null: false, default: false
  end
end
