class Event < ApplicationRecord
  validates :name, presence: true
  validates :introduction, presence: true
  validates :address, presence: true
  validate :event_dates_presence
  mount_uploader :image, ImageUploader
  has_many :event_dates, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :event_dates, reject_if: :all_blank, allow_destroy: true, limit: 3
  attr_accessor :remove_image
  before_save :remove_image_if_flagged

  def event_dates_presence
    # errors.add(:event_dates, "イベント開催日時を設定してください") if event_dates.none?
    # のようにif文は1行で書けたりします！
    if event_dates.none?
      errors.add(:event_dates, "イベント開催日時を設定してください")
    end
  end

  private

  def remove_image_if_flagged
    # '1'が何の数字か分からないので書き換えたいですね・・・

    # メソッド名にifがつくのはあまり見ない気が・・・
    # before_save :remove_image_if_flagged, if: :hoge
    # みたいな書き方もあるので、調べて見てください！
    self.image = nil if remove_image == '1'
  end
end
