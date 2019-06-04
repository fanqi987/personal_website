class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :likeable, polymorphic: true, index: true
      t.integer :user_id
      t.string :user_name, null: false
      t.timestamps
    end
  end
end
