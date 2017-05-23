class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.references :grade, foreign_key: true
      t.integer :roll_no
      t.string :name
      t.string :father_name
      t.integer :mobile_no
      t.string :gender
      t.timestamps
    end
  end
end
