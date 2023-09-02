class EventDate < ApplicationRecord
  belongs_to :event
  validates :event_day, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_end_check
  validate :date_in_future

  private

  def start_end_check
    if start_time && end_time
      errors.add(:start_time, "は終了時間より前に登録してください") unless start_time < end_time
    end
  end

  def date_in_future
    if event_day && end_time
      if event_day < Date.today || (event_day == Date.today && end_time > Time.now)
        errors.add(:event_day, "は過去の日時は選択できません。")
      end
    end
  end
end
