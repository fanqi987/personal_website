class CreateDiaries < ActiveRecord::Migration[5.1]
  def change
    create_table :diaries do |t|
      t.references :user, foreign_key: true
      t.string :title, null: false
      t.string :content, null: false
      t.integer :like, default: 0
      t.boolean :draft, default: true
      t.datetime :modified_time
      t.timestamps
    end
  end
end
