class AddVideoToMedia < ActiveRecord::Migration[6.0]
  def change
    add_column :media, :video, :string
  end
end
