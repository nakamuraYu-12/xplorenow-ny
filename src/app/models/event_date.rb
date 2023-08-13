class EventDate < ApplicationRecord
  belongs_to :event
  validates :event_day, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :start_end_check

  def start_end_check
    if (self.start_time != nil && self.end_time != nil)
      errors.add(:start_time, "は終了時間より前に登録してください") unless self.start_time < self.end_time
    end
  end
end
