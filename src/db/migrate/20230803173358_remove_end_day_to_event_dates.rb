class RemoveEndDayToEventDates < ActiveRecord::Migration[6.1]
  def change
    remove_column :event_dates, :end_day, :date
  end
end
