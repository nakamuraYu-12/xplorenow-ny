class Event < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  validates :address, presence: true
  validate :event_dates_presence
  validate :event_dates_limit3
  mount_uploader :image, ImageUploader
  has_many :event_dates, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :event_dates, reject_if: :all_blank, allow_destroy: true
  attr_accessor :remove_image
  before_save :remove_image_if_flagged

  def event_dates_presence
    errors.add(:base, "イベント開催日時を設定してください") if event_dates.none?
  end

  def event_dates_limit3
    errors.add(:base, "イベント開催日の登録は３日までにしてください") if event_dates.size > 3
  end

  private

  def remove_image_if_flagged
    self.image = nil if remove_image == '1'
  end
end
