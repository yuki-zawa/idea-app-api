class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :activation_digest
      t.datetime :activated_at
      t.boolean :activated

      t.timestamps
    end
  end
end
