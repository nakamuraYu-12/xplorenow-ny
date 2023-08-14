class EventDate < ApplicationRecord
  belongs_to :event
  validates :event_day, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_end_check
  validate :date_in_future

  private

  def start_end_check
    if self.start_time && self.end_time
      errors.add(:start_time, "は終了時間より前に登録してください") unless start_time < end_time
    end
  end

  def date_in_future
    errors.add(:event_day, "は過去の日付を選択できません。") if  event_day < Date.today
  end
end
