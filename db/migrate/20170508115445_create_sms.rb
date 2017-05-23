class CreateSms < ActiveRecord::Migration[5.0]
  def change
    create_table :sms do |t|
      t.references :student, foreign_key: true
      t.references :teacher, foreign_key: true
      t.string :sms_content
      t.timestamps
    end
  end
end
