class CreateGradesTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table :grades_teachers do |t|
      t.references :grade, foreign_key: true
      t.references :teacher, foreign_key: true
    end
  end
end
