require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
    test 'user should be valid' do
      user = User.new(email: '284811590_abcdefg@qq.com', name: 'fanqi987',
                      password: '19930218fq', password_confirmation: '19930218fq')
      assert user.valid?
    end
end
