class CreateLessonLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :lesson_links do |t|
      t.references :lesson, foreign_key: true
      t.string :name
      t.string :link_url

      t.timestamps
    end
  end
end
