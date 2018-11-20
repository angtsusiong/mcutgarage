class Badge < ApplicationRecord
  has_many :badges_projects
  has_many :projects, through: :badges_projects
  has_paper_trail
end
