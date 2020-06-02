class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :appliances
  has_many :smart_home_systems
  has_one :utility_account

  validates :first_name, presence: true
  validates :last_name, presence: true
end
