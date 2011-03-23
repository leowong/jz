class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :username, :email, :password, :password_confirmation, :mobile, :phone

  cattr_accessor :current_user

  attr_accessor :password
  before_save :prepare_password

  has_many :activities
  has_many :billboards

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[^\s]+$/i, :allow_blank => true, :message => "should not contain whitespace characters"
  /\s/
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  def name
    self == User.current_user ? I18n.t('users.me') : username
  end

  def assigned_tasks
    Task.where(:assigned_to => id)
  end

  def assigning_tasks
    Task.where("user_id = :current_user_id AND assigned_to <> :current_user_id", :current_user_id => User.current_user.id )
  end
  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end
