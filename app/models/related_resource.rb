class RelatedResource < ApplicationRecord
  belongs_to :resource_category

  validates :title, :content, presence: true
  has_paper_trail
end
