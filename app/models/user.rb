class User < ApplicationRecord
	validates :name, presence: true
	validates :email, presence: true, uniqueness: true
	validates :password , presence: true
	validates :confirm, presence: true
	validates :mobile, presence: true, numericality: true
  has_one :image 
  accepts_nested_attributes_for :image
    before_save :encrypt_password
    before_save :check_name
    before_validation :verify_password
    devise :omniauthable
def check_name
  if name.blank?
    self.name="unknow"
  end
end
    def encrypt_password
       self.password = Digest::MD5.hexdigest(password)
       self.confirm = Digest::MD5.hexdigest(confirm)
    end
    def verify_password
     	if password != confirm
           errors.add(:base, "password & confirm_password are not equal!" )
    	end
    end
	def self.authenticate(email, password)

		if @user = User.where(email: email, password: Digest::MD5.hexdigest(password)).last
           @user
       else
       	nil
       end
	end
end


  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
  end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
         #:recoverable, :rememberable, :trackable, :validatable

def send_devise_notification(notification, *args)
  devise_mailer.send(notification, self, *args).deliver_later
end

