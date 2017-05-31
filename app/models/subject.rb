class Subject < ApplicationRecord
  validates :subject_name, presence: true
  validates :subject_name, :uniqueness => true
  
  default_scope ->{ order(subject_name: :asc) }
end
