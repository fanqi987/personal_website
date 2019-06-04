class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.references :user, foreign_key: true
      t.text :content, null: false
      t.string :picture
      t.string :video
      t.integer :like, default: 0
      t.timestamps
    end
    # add_index :microposts,:user_id
  end

end
