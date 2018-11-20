class ProjectCategory < ApplicationRecord
  has_many :projects
  validates :name, :brief_intro, presence: true
  has_paper_trail
end
