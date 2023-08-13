class Event < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  validates :address, presence: true
  mount_uploader :image, ImageUploader
  has_many :event_dates, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :event_dates, reject_if: :all_blank, allow_destroy: true
end
