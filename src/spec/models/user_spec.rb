require 'rails_helper'

RSpec.describe User, type: :model do
  let(:bookmark_event) { create(:event, name: 'BookmarkEvent', introduction: "test", address: "千葉") }
  it "ゲストユーザーが作成されるか" do
    guest_user = User.guest
    expect(guest_user.email).to eq('guest@example.com')
    expect(guest_user).to be_valid
  end

  it "イベントのブックマーク操作ができるか" do
    user = User.create(name: "text1", email: "test1@example.com", password: "password")
    user.event_bookmark(bookmark_event)
    expect(user.event_bookmarked?(bookmark_event)).to be(true)
  end

  it "イベントのブックマークを解除できるか" do
    user = User.create(name: "text2", email: "text2@example.com", password: "password")
    user.event_bookmark(bookmark_event)
    user.event_unbookmark(bookmark_event)
    expect(user.event_bookmarked?(bookmark_event)).to be(false)
  end
end
