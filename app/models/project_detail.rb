class ProjectDetail < ApplicationRecord
  belongs_to :project
  belongs_to :requirement
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  has_paper_trail
end
