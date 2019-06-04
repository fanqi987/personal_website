require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:user1)
  end

  test 'user post successful' do
    userLoginPost_as(@user)
    assert_redirected_to /#{login_path}/
    follow_redirect!
    # p response
    assert_select '.alert-success'
  end

  test 'user post failed' do
    userLoginPost_as(@user,password: '1123')
    assert_redirected_to /#{login_path}/
    follow_redirect!
    assert_select '.alert-danger'
  end

  test 'user post successful with remember and log out' do
    userLoginPost_as(@user,remember_me: '1')
    assert_redirected_to /#{login_path}/
    assert cookies[:remember_token]
    assert_equal assigns(:user).remember_token,cookies[:remember_token]
    follow_redirect!
    assert_select '.alert-success'
    # get login_path
    # assert_redirected_to /#{login_profile_path}/
    userLogout
    assert_redirected_to /#{login_path}/
    follow_redirect!
    assert_select "a:match('href',?)",/#{login_path}/,text:'用户登录'
    assert_not session[:user_id]
    assert_empty cookies[:user_id]
    assert_empty cookies[:remember_token]
    # assert_select "a:match('href',?)", /#{login_profile_path}/,text: @user.name
    # assert_select "a[href=?]", /#{login_profile_path}/ ,text: @user.name
  end


end
