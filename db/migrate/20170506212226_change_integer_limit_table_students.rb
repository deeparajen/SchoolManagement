class ChangeIntegerLimitTableStudents < ActiveRecord::Migration[5.0]
  def up
    change_column :students, :mobile_no, :string
  end
  
  def down
    change_column :students, :mobile_no, :integer, limit: 8
  end
end
