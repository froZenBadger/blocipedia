class User < ActiveRecord::Base
  has_many :wikis

  enum role: [:standard, :premium, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :standard
  end

  #Devise default modules: :lockable, :timeoutable and :omniauthable :confirmable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable 

 def avatar_url(size)
   gravatar_id = Digest::MD5::hexdigest(self.email).downcase
   "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
 end
end
