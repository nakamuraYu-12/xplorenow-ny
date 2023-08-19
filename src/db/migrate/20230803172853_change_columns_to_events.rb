class ChangeColumnsToEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :event_dates, :start_day, :date
    add_column :event_dates, :event_day, :date
  end
end
