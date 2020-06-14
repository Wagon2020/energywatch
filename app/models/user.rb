class User < ApplicationRecord
  acts_as_token_authenticatable

  after_create :send_welcome_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :pwned_password

  has_many :appliances
  has_many :smart_home_systems
  has_many :smart_plugs
  has_one :utility_account

  validates :first_name, presence: true
  validates :last_name, presence: true

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end
end
