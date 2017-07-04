class User < ActiveRecord::Base
  has_many :wikis

  before_save { self.email = email.downcase if email.present? }

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 254 },
             format: { with: EMAIL_REGEX}

  has_secure_password
  
  #Devise default modules: :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

 def avatar_url(size)
   gravatar_id = Digest::MD5::hexdigest(self.email).downcase
   "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
 end
end
