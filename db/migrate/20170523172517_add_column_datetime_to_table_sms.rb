class AddColumnDatetimeToTableSms < ActiveRecord::Migration[5.0]
  def change
    add_column :sms, :task_date, :datetime
  end
end
