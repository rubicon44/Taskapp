class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :name, limit: 30, null: false
      t.text :description

      t.timestamps
      t.index :name, unique: true
    end
  end
end
