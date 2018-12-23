class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name,       :null => false
      t.text :description,  :null => false
      t.integer :price,     :null => false
      t.integer :discount,  :null => false
      t.boolean :published, :default => false

      t.timestamps
    end
  end
end
