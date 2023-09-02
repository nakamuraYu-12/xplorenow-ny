require 'rails_helper'

RSpec.describe EventDate, type: :model do
  describe "バリデーション" do
    let(:event) { Event.create(name: "イベント名", introduction: "イベント詳細", address: "住所") }

    it "event_dayが存在しない場合は無効であること" do
      event_date = EventDate.new(event: event, event_day: nil)
      event_date.valid?
      expect(event_date.errors[:event_day]).to include("を入力してください")
    end

    it "start_timeが存在しない場合は無効であること" do
      event_date = EventDate.new(event: event, start_time: nil)
      event_date.valid?
      expect(event_date.errors[:start_time]).to include("を入力してください")
    end

    it "end_timeが存在しない場合は無効であること" do
      event_date = EventDate.new(event: event, end_time: nil)
      event_date.valid?
      expect(event_date.errors[:end_time]).to include("を入力してください")
    end

    it "start_timeがend_timeより前でない場合は無効であること" do
      event_date = EventDate.new(event: event, start_time: Time.now, end_time: Time.now)
      event_date.valid?
      expect(event_date.errors[:start_time]).to include("は終了時間より前に登録してください")
    end

    it "過去の日時の場合は無効であること" do
      event_date = EventDate.new(event: event, event_day: Date.new(1993, 2, 24), end_time: Time.now)
      event_date.valid?
      expect(event_date.errors[:event_day]).to include("は過去の日時は選択できません。")
    end
  end
end
