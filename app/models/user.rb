class User < ActiveRecord::Base
  has_many :commits
  validates_presence_of :first_name, :last_name
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :nick_name, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end