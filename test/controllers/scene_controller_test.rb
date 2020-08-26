require 'test_helper'

class SceneControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get scene_new_url
    assert_response :success
  end

  test "should get edit" do
    get scene_edit_url
    assert_response :success
  end

  test "should get update" do
    get scene_update_url
    assert_response :success
  end

end
