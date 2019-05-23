ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def userRegisterPost(email, name, password, password_confirmation)
    post register_path, params: {user: {email: email, name: name,
                                        password: password, password_confirmation: password_confirmation}}
  end

  def userLoginPost (email: '284811590@qq.com', password: '19930218fq', remember_me: '0')
    # p remember_me
    post login_path, params: {session: {email: email,
                                        password: password, remember_me: remember_me}}
  end

  def userLoginPost_as (user,password:'19930218fq',remember_me: '0')
    # p remember_me
    post login_path, params: {session: {email: user.email,
                                        password: password, remember_me: remember_me}}
  end

  def userLogout
    delete login_profile_path
  end
end
