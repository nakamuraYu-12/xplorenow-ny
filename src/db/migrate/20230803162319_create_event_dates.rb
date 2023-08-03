class CreateEventDates < ActiveRecord::Migration[6.1]
  def change
    create_table :event_dates do |t|
      t.integer :event_id
      t.date :start_day
      t.time :start_time
      t.date :end_day
      t.time :end_time
      t.timestamps
    end
  end
end
