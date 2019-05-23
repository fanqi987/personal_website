require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get home_url
    assert_response :success
  end

  test "should get micropost" do
    get micropost_url
    assert_response :success
  end

  test "should get diary" do
    get diary_url
    assert_response :success
  end

  test "should get hobby" do
    get hobby_url
    assert_response :success
  end

  test "should get profile" do
    get profile_url
    assert_response :success
  end

  test "should get messageboard" do
    get messageboard_url
    assert_response :success
  end

end
