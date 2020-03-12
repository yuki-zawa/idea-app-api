class CreateIdeaIdeaTags < ActiveRecord::Migration[6.0]
  def change
    create_table :idea_idea_tags do |t|
      t.references :idea, null: false, foreign_key: true
      t.references :idea_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
