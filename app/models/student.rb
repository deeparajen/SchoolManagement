class Student < ApplicationRecord
  belongs_to :grade
  has_one :sm
    validates :name,:presence => true
    #validates :roll_no,:presence => true
    #validates :father_name,:presence => true
    #validates :grade_id,:presence => true
    #validates_format_of :mobile_no, :with =>  /\d[0-9]\)*\z/ , :message => "Only positive number without spaces are allowed"
end
