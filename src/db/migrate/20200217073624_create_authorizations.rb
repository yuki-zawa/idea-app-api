class CreateAuthorizations < ActiveRecord::Migration[6.0]
  def change
    create_table :authorizations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uid
      t.string :provider
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
