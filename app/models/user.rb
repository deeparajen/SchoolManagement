class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  before_create :set_default_role
  
  def role?(role)
    self.role.name == role.to_s.capitalize
  end
  
  private
  def set_default_role
    # Add the default role if no roles is set
    #self.roles << Role.find_by_admin('Admin') if roles.empty?
    self.role = Role.find_by_name('Staff') if self.role.nil?
  end
  
  
end
