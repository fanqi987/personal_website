class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :commentable, polymorphic: true, index: true
      t.string :user_name, null: false
      t.integer :user_id
      t.text :content, null: false
      t.integer :like, default: 0
      t.string :avatar
      t.string :email
      t.timestamps
    end
  end
end
