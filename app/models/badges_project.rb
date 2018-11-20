class BadgesProject < ApplicationRecord
  belongs_to :progect
  belongs_to :badge
  has_paper_trail
end
