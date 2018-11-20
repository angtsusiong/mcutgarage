class Slide < ApplicationRecord
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  has_paper_trail
end
