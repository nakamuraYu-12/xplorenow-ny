require 'rails_helper'

RSpec.describe Event, type: :model do
    it "nameが存在しない場合は無効であること" do
      event = Event.new(name: nil)
      event.valid?
      expect(event.errors[:name]).to include("を入力してください")
    end

    it "introductionが存在しない場合は無効であること" do
      event = Event.new(introduction: nil)
      event.valid?
      expect(event.errors[:introduction]).to include("を入力してください")
    end

    it "addressが存在しない場合は無効であること" do
      event = Event.new(address: nil)
      event.valid?
      expect(event.errors[:address]).to include("を入力してください")
    end

    it "イベント日時が存在しない場合は無効であること" do
      event = Event.new
      event.valid?
      expect(event.errors[:base]).to include("イベント開催日時を設定してください")
    end

    it "最大で3つのイベント日時を許可する" do
      event_start_time = Time.new(2000, 1, 1,13, 30, 0, "+09:00")
      event = Event.new(
        user: create(:user),
        name: "イベント名",
        introduction: "イベント詳細",
        address: "東京",
        event_dates_attributes: [
          { event_day: Date.tomorrow, start_time: event_start_time, end_time: event_start_time + 1.hour },
          { event_day: Date.tomorrow + 1, start_time: event_start_time, end_time: event_start_time + 1.hour },
          { event_day: Date.tomorrow + 2, start_time: event_start_time, end_time: event_start_time + 1.hour }
        ]
      )
      expect(event).to be_valid
    end

    it "4つ以上のイベント日時は無効であること" do
      event = Event.new
      4.times { event.event_dates.build }
      event.valid?
      expect(event.errors[:base]).to include("イベント開催日の登録は３日までにしてください")
    end

end
