class CreateMaterials < ActiveRecord::Migration[5.1]
  def change
    create_table :materials do |t|
      t.references :user, foreign_key: true
      t.string :title, null: false
      t.string :content, null: false
      t.string :type, null: false
      t.string :href, null: false
      t.timestamps
    end
  end
end
