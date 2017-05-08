class ChangeIntegerDtypeToStringTableTeacher < ActiveRecord::Migration[5.0]
  def up
    change_column :teachers, :mobile_no, :string
  end
  
  def down
    change_column :teachers, :mobile_no, :integer
  end
end
