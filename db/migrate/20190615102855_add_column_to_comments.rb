class AddColumnToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :avatar, :string
  end
end
