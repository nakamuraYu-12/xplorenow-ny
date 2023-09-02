require 'rails_helper'

RSpec.describe 'Google Mapsの機能', type: :system do
  before do
    event_start_time = Time.new(2000, 1, 1, 13, 30, 0, "+09:00")
    @events = []
    @events << Event.create!(
      user: create(:user),
      name: "イベント名1",
      introduction: "イベント詳細1",
      address: "東京都墨田区押上１丁目１−２",
      event_dates_attributes: [
        { event_day: Date.tomorrow, start_time: event_start_time, end_time: event_start_time + 1.hour }
      ]
    )
    @events << Event.create!(
      user: create(:user),
      name: "イベント名2",
      introduction: "イベント詳細2",
      address: "東京都墨田区押上２丁目２−３",
      event_dates_attributes: [
        { event_day: Date.tomorrow + 1, start_time: event_start_time, end_time: event_start_time + 1.hour }
      ]
    )
    visit root_path
  end

  it '住所でイベントを検索できること' do
    fill_in 'searchAddress', with: '東京都墨田区押上１丁目１−２'
    find_button('Search', id: 'searchAddressButton').click
    expect(page).to have_content('イベント名1')
  end

  it 'キーワードでイベントを検索できること' do
    fill_in 'searchKeyword', with: 'イベント名2'
    find_button('Search', id: 'searchKeywordButton').click
    expect(page).to have_content('イベント名2')
  end
end
