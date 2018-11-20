class Article < ApplicationRecord
  belongs_to :user
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, :allow_destroy => true
  validates :title, presence: true
  enum status: [ :draft, :pending, :published]
  has_paper_trail
end
