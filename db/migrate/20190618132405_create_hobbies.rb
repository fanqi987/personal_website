class CreateHobbies < ActiveRecord::Migration[5.1]
  def change
    create_table :hobbies do |t|
      t.references :user, forigen_key: true
      t.string :title, null: false
      t.string :content
      t.timestamps
    end
  end
end
