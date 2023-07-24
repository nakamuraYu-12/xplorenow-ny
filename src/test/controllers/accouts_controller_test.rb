require "test_helper"

class AccoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get accouts_show_url
    assert_response :success
  end
end
