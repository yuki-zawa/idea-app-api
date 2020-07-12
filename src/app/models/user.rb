class User < ApplicationRecord
  has_secure_token
  has_secure_password
  attr_accessor :activation_token
  before_save { self.email = email.downcase }
  before_create :create_activation_digest
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_many :authorizations, dependent: :destroy
  has_many :ideas, dependent: :destroy
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  # SNS
  def User.create_from_auth!(auth)
    #authの情報を元にユーザー生成の処理を記述
    #auth["credentials"]にアクセストークン、シークレットなどの情報
    #auth["info"]["email"]にユーザーのメールアドレス
    @user = User.new(email: auth["info"]["email"], password: "google-oauth2", password_confirmation: "google-oauth2", activated: true, activated_at: Time.zone.now, token: auth["credentials"]["token"])
    if @user.save
      @user
    else
      render status: 400, :json => { status: "400", message: "this mail address has already existed" }
    end
  end

  # token check
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Random Token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

    # アカウントを有効にする
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end
  
  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private
    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
