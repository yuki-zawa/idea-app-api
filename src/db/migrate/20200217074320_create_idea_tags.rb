class CreateIdeaTags < ActiveRecord::Migration[6.0]
  def change
    create_table :idea_tags do |t|
      t.references :idea, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
