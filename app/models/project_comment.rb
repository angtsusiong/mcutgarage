class ProjectComment < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_paper_trail

  validates :content, presence: true
end
