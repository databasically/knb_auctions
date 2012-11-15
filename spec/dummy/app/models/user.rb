class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :full_name, :goodles, :email, :password, :password_confirmation, :remember_me
  
  def admin?
    false
  end
end
