class CreateMicropostRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :micropost_records do |t|
      t.references :micropost, foreign_key: true
      t.string :user_name,null:false
      t.integer :user_id
      t.text :content,null:false
      t.integer :like,default:0

      t.timestamps
    end
    # add_index :micropost_records,:micropost_id
  end
end
