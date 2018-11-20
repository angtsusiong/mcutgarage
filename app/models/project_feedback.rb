class ProjectFeedback < ApplicationRecord
  belongs_to :project
  validates :content, presence: true
  has_paper_trail
end
