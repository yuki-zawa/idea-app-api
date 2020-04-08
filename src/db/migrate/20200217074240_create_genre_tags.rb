class CreateGenreTags < ActiveRecord::Migration[6.0]
  def change
    create_table :genre_tags do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :color
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
