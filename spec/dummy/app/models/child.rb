class Child < ActiveRecord::Base
  attr_accessible :goodles, :full_name, :user_id

  belongs_to :user
  
  before_create :set_default_goodles

  def active?
  	true
  end

  def available_activation_action
    active? ? "Active" : "Deactivated"
  end

private

  def set_default_goodles
    self.goodles = 100 if goodles.nil?
  end
end
