class CreateTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table :teachers do |t|
      t.string :full_name
      t.integer :mobile_no
      t.string :qualification
      t.timestamps
    end
  end
end
