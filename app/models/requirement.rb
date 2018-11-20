class Requirement < ApplicationRecord
  has_many :requirements_steps
  has_many :steps, through: :requirements_steps
  has_many :project_details

  validates :name, presence: true
  enum datatype: [ :text, :picture, :video ]
  has_paper_trail
end
