class CreateIdeaTags < ActiveRecord::Migration[6.0]
  def change
    create_table :idea_tags do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.boolean :status, default: true

      t.timestamps
    end
  end
end
