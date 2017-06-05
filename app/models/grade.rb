class Grade < ApplicationRecord
  has_many :students
  has_and_belongs_to_many :teachers,dependent: :destroy
 
 validates :grade_name, presence: true
 validates :grade_name, :uniqueness => true

 default_scope ->{ order(grade_name: :asc) }

end
