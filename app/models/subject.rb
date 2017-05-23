class Subject < ApplicationRecord
  validates :subject_name, presence: true
  validates :subject_name, :uniqueness => true
end
