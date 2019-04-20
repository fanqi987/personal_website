require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
  end

  test "should get micropost" do
    get static_pages_micropost_url
    assert_response :success
  end

  test "should get diary" do
    get static_pages_diary_url
    assert_response :success
  end

  test "should get hobby" do
    get static_pages_hobby_url
    assert_response :success
  end

  test "should get profile" do
    get static_pages_profile_url
    assert_response :success
  end

  test "should get messageboard" do
    get static_pages_messageboard_url
    assert_response :success
  end

end
