class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :password_digest
      t.boolean :admin,default:false
      t.string :remember_digest
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.timestamps
    end

    add_index :users,:email,unique:true
  end
end
