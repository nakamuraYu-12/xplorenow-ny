require 'rails_helper'

RSpec.describe User, type: :model do
  it "ゲストユーザーが作成されるか" do
    guest_user = User.guest
    expect(guest_user.email).to eq('guest@example.com')
    expect(guest_user).to be_valid
  end

  it "イベントのブックマーク操作ができるか" do
    user = User.create(name: "text1", email: "test1@example.com", password: "password")
    event_start_time = Time.new(2000, 1, 1, 13, 30, 0, "+09:00")
    bookmarks_event = Event.new(
      user: create(:user),
      name: "イベント名",
      introduction: "イベント詳細",
      address: "東京",
      event_dates_attributes: [
        { event_day: Date.tomorrow, start_time: event_start_time, end_time: event_start_time + 1.hour },
      ]
    )
    user.event_bookmark(bookmarks_event)
    expect(user.event_bookmarked?(bookmarks_event)).to be(true)
  end

  it "イベントのブックマークを解除できるか" do
    user = User.create(name: "text2", email: "text2@example.com", password: "password")
    event_start_time = Time.new(2000, 1, 1, 13, 30, 0, "+09:00")
    bookmarks_event = Event.new(
      user: create(:user),
      name: "イベント名",
      introduction: "イベント詳細",
      address: "東京",
      event_dates_attributes: [
        { event_day: Date.tomorrow, start_time: event_start_time, end_time: event_start_time + 1.hour },
      ]
    )
    user.event_bookmark(bookmarks_event)
    user.event_unbookmark(bookmarks_event)
    expect(user.event_bookmarked?(bookmarks_event)).to be(false)
  end
end
