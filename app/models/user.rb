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

 def downgrade
   self.update(role: 'standard')
   downgrade_wikis
 end

 def downgrade_wikis
   if self.role == 'standard'
     self.wikis.each do |wiki|
       wiki.update(private: false)
     end
   end
 end
end
