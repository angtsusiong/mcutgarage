class ProjectsUser < ApplicationRecord
  belongs_to :project
  belongs_to :user
  enum typing: [ :leader, :member, :follower, :examiner, :the_examiner]
  has_paper_trail
end
