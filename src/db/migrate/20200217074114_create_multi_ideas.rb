class CreateMultiIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :multi_ideas do |t|
      t.string :title
      t.text :detail
      t.float :priority
      t.string :color

      t.timestamps
    end
  end
end
