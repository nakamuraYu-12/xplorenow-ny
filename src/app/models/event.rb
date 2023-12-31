class Event < ApplicationRecord
  has_many :event_tags, dependent: :destroy
  has_many :tags, through: :event_tags
  validates :name, presence: true
  validates :introduction, presence: true
  validates :address, presence: true
  validate :event_dates_presence
  validate :event_dates_update_presence
  validate :event_dates_limit3
  mount_uploader :image, ImageUploader
  has_many :event_dates, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :event_dates, reject_if: :all_blank, allow_destroy: true
  attr_accessor :remove_image
  before_save :remove_image_flagged, if: :remove_image_flagged

  def event_dates_presence
    errors.add(:base, "イベント開催日時を設定してください") if event_dates.none?
  end

  def event_dates_update_presence
    if event_dates.reject(&:marked_for_destruction?).empty?
      errors.add(:base, "イベント開催日時を設定してください")
    end
  end

  def event_dates_limit3
    errors.add(:base, "イベント開催日の登録は３日までにしてください") if event_dates.size > 3
  end

  def save_event_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      workout_tag = Tag.find_or_create_by(name: new_name)
      self.tags << workout_tag
    end
  end

  private

  def remove_image_flagged
    self.image = nil if remove_image
  end
end
