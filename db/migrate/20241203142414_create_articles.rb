class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :name
      t.text :content
      t.references :term, null: false, foreign_key: true

      t.timestamps
    end
  end
end
