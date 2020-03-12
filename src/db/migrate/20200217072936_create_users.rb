class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false
      t.string :password_digest, null: false
      t.string :remember_digest
      t.string :activation_digest
      t.datetime :activated_at
      t.boolean :activated, default: false
      t.boolean :status, default: true
      t.string :token

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :token, unique: true
  end
end
