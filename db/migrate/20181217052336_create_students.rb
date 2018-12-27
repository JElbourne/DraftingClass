class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.references :user, foreign_key: true
      t.references :course, foreign_key: true

      t.timestamps
    end

    add_index :students, [ :user_id, :course_id ], :unique => true, :name => 'by_user_and_course'

  end
end
