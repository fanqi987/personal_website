class CreateHobbyItems < ActiveRecord::Migration[5.1]
  def change
    create_table :hobby_items do |t|
      t.references :hobby, forigen_key: true
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :content
      t.string :image, null: false
      t.boolean :cover, default: false
      t.integer :like, default: 0
      t.timestamps
    end
  end
end
