require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  #
  test 'should get register page' do
    get register_path
    assert_response :success
  end

end
