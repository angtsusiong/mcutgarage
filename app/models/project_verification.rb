class ProjectVerification < ApplicationRecord
  belongs_to :project
  belongs_to :step
  has_paper_trail
end
