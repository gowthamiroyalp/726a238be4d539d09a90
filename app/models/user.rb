class User < ActiveRecord::Base

  has_many :questions, through: :answers
  has_many :topics, dependent: :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise_modules = []

  devise_modules += if ENV['OSEM_ICHAIN_ENABLED'] == 'true'
                      [:ichain_authenticatable, :ichain_registerable, :omniauthable, omniauth_providers: []]
                    else
                      [:database_authenticatable, :registerable,
                       :recoverable, :rememberable, :trackable, :validatable, :confirmable,
                       :omniauthable, omniauth_providers: [:suse, :google, :facebook, :github]]
                    end

  devise(*devise_modules)

  attr_accessor :login

  validates :email, presence: true

  validates :username,
            uniqueness: {
                case_sensitive: false
            },
            presence: true

  def name
    self[:name].blank? ? username : self[:name]
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # Searches for user based on email. Returns found user or new user.
  # ====Returns
  # * +User::ActiveRecord_Relation+ -> user
  def self.find_for_auth(auth, current_user = nil)
    user = current_user

    if user.nil? # No current user available, user is not already logged in
      user = User.where(email: auth.info.email).first_or_initialize
    end

    if user.new_record?
      user.email = auth.info.email
      user.name = auth.info.name
      user.username = auth.info.username
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end

    user
  end

  # is guest follewed by user
  def follow(id)
	@user.id == id ? true : doFollow(id)
  end
  
  def doFollow(id)
    @user_topic.follow = true
    false
  end
  
end
