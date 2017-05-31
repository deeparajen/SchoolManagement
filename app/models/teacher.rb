class Teacher < ApplicationRecord
  has_one :sm
  has_and_belongs_to_many :grades
 
 validates :mobile_no, length: {is: 10, message: "must be 10 digit long."},  numericality: { only_integer: true }, uniqueness: true
 validates :full_name, presence: true
 validates :qualification,:presence => true
 
 default_scope ->{ order(full_name: :asc) }
end
