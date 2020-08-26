require 'test_helper'

class ArchivedEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get archived_events_index_url
    assert_response :success
  end

end
