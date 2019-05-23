require 'test_helper'

class UserRegisterTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:user1)
  end
  test "user post should be valid and correct redirection" do
    get register_path
    assert_template 'users/new'
    assert_select 'form[action=?]', '/register'
    assert_difference 'User.count' do
      userRegisterPost '284811590_abcdefg@qq.com', 'fanqi987', '19930218fq', '19930218fq'
    end
    assert_redirected_to register_success_path
    follow_redirect!
    assert_select "div.alert-success"
    #
    # sleep 6
    # assert_template 'sessions/new'

  end

  test 'user infos should be correct' do
    get register_path
    #duplicate email
    assert_no_difference 'User.count' do
      userRegisterPost '284811590@qq.com', 'fanqi987', '19930218fq', '19930218fq'
    end
    assert_select '.error_explanation .alert-danger'
    #password doesn't match confirmation
    assert_no_difference 'User.count' do
      userRegisterPost '284811590_abcdefg@qq.com', 'fanqi987', '19930218fq', '19930218'
    end
  end

end
