require 'rails_helper'

RSpec.describe 'Google Maps functionality', type: :system do
  before do
    event_start_time = Time.new(2000, 1, 1, 13, 30, 0, "+09:00")
    @event = Event.new(
      user: create(:user),
      name: "イベント名",
      introduction: "イベント詳細",
      address: "東京都墨田区押上１丁目１−２",
      event_dates_attributes: [
        { event_day: Date.tomorrow, start_time: event_start_time, end_time: event_start_time + 1.hour },
        { event_day: Date.tomorrow + 1, start_time: event_start_time, end_time: event_start_time + 1.hour },
        { event_day: Date.tomorrow + 2, start_time: event_start_time, end_time: event_start_time + 1.hour }
      ]
    )
    visit root_path
  end

  it '地域検索ができること' do
    fill_in 'searchAddress', with: '東京都港区芝公園４丁目２−８'
    click_button '.search_address_btn'
    selenium_chrome('#map [data-lat="35.658728665449345"]')
    expect(page).to have_css('#map [data-lng="139.7459049650982"]')
  end

  it 'イベントカードをクリックするとマップに反映され、カードが活性化すること' do
    find(".clickable-card[data-event-id='#{@event.id}']").click
    expect(page).to have_css('.card.border-primary')
    expect(page).to have_css('#map [data-lat="35.71027922773935"]')
    expect(page).to have_css('#map [data-lng="139.81074489819264"]')
  end

end
