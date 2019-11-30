class AddContentTypeToMedia < ActiveRecord::Migration[6.0]
  def change
    add_column :media, :content_type, :string, null: false, default: ''
  end
end
