class ChangeRollNoDtypeToStringTableStudents < ActiveRecord::Migration[5.0]
  def up
    change_column :students, :roll_no, :string
  end
  
  def down
    change_column :students, :roll_no, :integer
  end
end
