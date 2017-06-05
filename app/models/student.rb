class Student < ApplicationRecord
  belongs_to :grade
  has_one :sm,dependent: :destroy
  
    validates :name, presence: true
    validates :roll_no, presence: true, uniqueness: true
    validates :father_name,:presence => true
    validates :grade_id,presence: true
    validates :mobile_no, length: {is: 10, message: "must be 10 digit long."},  numericality: { only_integer: true }, uniqueness: true
    
    default_scope ->{ order(name: :asc) }
end
