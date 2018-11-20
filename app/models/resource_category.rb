class ResourceCategory < ApplicationRecord
  has_many :related_resources

  validates :name, presence: true
  has_paper_trail
end
