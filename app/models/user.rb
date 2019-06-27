class User < ApplicationRecord

  has_many :diaries, dependent: :destroy
  has_many :microposts, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :hobbies, dependent: :destroy
  has_one :message, dependent: :destroy
  has_many :materials, dependent: :destroy
  #todo 邮箱的正确格式,其它属性的最小长度
  validates :email, presence: {message: '邮箱不能为空'},
            length: {maximum: 255, message: '邮箱内容过长'},
            format: {with: /\w+@\w+/, message: '邮箱格式错误'},
            uniqueness: {case_sensitive: false, message: '注册邮箱已存在'}
  validates :name, presence: {message: '用户名不能为空'},
            length: {maximum: 50, message: '用户名内容过长'},
            uniqueness: {message: '已经存在的用户名'}


  validates :password, presence: {message: '密码不能为空'},
            allow_nil: true,
            length: {minimum: 6, message: '密码太短'}

  validates_confirmation_of :password,
                            message: '再次输入密码不匹配',
                            allow_nil: true

  has_secure_password
  attr_accessor :remember_token


  def User.digest pwd
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(pwd, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    @remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def User.authenticate_digest symbol, token
    digest = send("#{symbol}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def validate_modify_password(pwd)
    # 修改信息的情况,覆盖掉密码验证,当输入密码为空时,修改密码应当失败(默认allow_nil,可以为空密码)
    # 注册信息的情况,覆盖掉安全密码验证,当输入密码为空时,应当使用密码验证的提示(默认被安全密码验证信息覆盖了,现在重新覆盖下)
    return true if !pwd.empty?
    errors.add(:password, '请填写正确的密码')
    return false
  end
  # def User.authenticate user
  #   #
  #   user=User.
  #
  # end
end
