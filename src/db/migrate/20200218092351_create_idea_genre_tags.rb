class CreateIdeaGenreTags < ActiveRecord::Migration[6.0]
  def change
    create_table :idea_genre_tags do |t|
      t.references :idea, null: false, foreign_key: true
      t.references :genre_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
