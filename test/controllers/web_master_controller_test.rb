require 'test_helper'

class WebMasterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get web_master_index_url
    assert_response :success
  end

end
