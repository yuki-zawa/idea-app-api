class CreateIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :ideas do |t|
      t.references :user, null: false, foreign_key: true
      t.string :icon
      t.string :title
      t.text :detail
      t.float :priority
      t.boolean :status, default: true
      
      t.timestamps
    end
  end
end
