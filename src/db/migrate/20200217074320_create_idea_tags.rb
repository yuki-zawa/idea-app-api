class CreateIdeaTags < ActiveRecord::Migration[6.0]
  def change
    create_table :idea_tags do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.boolean :status, default: true

      t.timestamps
    end
    add_index  :idea_tags, [:name, :user_id], unique: true
  end
end
