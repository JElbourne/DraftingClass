class CreateLessons < ActiveRecord::Migration[5.2]
  def change
    create_table :lessons do |t|
      t.references :course, foreign_key: true
      t.string :title,      null: false
      t.text :transcript,   null: false
      t.integer :length,    null: false
      t.string :video_url,  null: false
      t.boolean :published, default: false

      t.timestamps
    end
  end
end
