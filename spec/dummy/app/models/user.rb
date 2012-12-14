class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :full_name, :goodles, :email, :password, :password_confirmation, :remember_me
  
  def admin?
    true
  end
  
  def child?
    true
  end
  
  def goodles
    100000
  end
  
  def full_name
    "Johnny Smith"
  end
end
