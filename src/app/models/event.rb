class Event < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  validates :address, presence: true
  validate :event_dates_presence
  mount_uploader :image, ImageUploader
  has_many :event_dates, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :event_dates, reject_if: :all_blank, allow_destroy: true, limit: 3

  def event_dates_presence
    if event_dates.none?
      errors.add(:event_dates, "イベント開催日時を設定してください")
    end
  end
end
