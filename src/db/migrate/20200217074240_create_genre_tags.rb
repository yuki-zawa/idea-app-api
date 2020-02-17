class CreateGenreTags < ActiveRecord::Migration[6.0]
  def change
    create_table :genre_tags do |t|
      t.references :idea, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
