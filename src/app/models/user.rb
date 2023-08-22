class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :events, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarks_events, through: :bookmarks, source: :event
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  mount_uploader :image, ImageUploader
  validates :name, length: { minimum: 1, maximum: 30 }

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲストユーザー"
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def bookmark(event)
    bookmarks_events << event
  end

  def unbookmark(event)
    bookmarks_events.delete(event)
  end

  def bookmark?(event)
    bookmarks_events.include?(event)
  end
end
