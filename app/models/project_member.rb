class ProjectMember < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_paper_trail
  validates :job_title, :brief_intro, presence: true
end
