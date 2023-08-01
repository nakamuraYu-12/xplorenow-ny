class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :introduction
      t.string :address
      t.date :start_day
      t.date :end_day
      t.time :start_time
      t.time :end_time
      t.string :image

      t.timestamps
    end
  end
end
