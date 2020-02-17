class CreateIdeaMultiIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :idea_multi_ideas do |t|
      t.references :multi_idea, null: false, foreign_key: true
      t.references :idea, null: false, foreign_key: true

      t.timestamps
    end
  end
end
