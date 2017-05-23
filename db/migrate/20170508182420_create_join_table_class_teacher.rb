class CreateJoinTableClassTeacher < ActiveRecord::Migration[5.0]
  def change
    create_join_table :Grades, :Teachers do |t|
      t.index [:grade_id, :teacher_id]
      # t.index [:grade_id, :teacher_id]
      # t.index [:teacher_id, :grade_id]
    end
  end
end
