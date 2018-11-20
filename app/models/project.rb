class Project < ApplicationRecord
  has_many :projects_users
  has_many :users, through: :projects_users
  accepts_nested_attributes_for :projects_users, reject_if: :all_blank, allow_destroy: true
  belongs_to :project_category
  has_many :project_visitors
  has_many :badges_projects
  has_many :badges, through: :badges_projects
  has_many :project_details
  accepts_nested_attributes_for :project_details, reject_if: :all_blank, allow_destroy: true
  has_many :requirements, through: :project_details
  belongs_to :activity
  has_paper_trail
  validates :name, presence: true
  enum status: [ :draft, :pending, :examining ,
    :denied, :passed ]

#  after_create :set_project_detail


  def set_detail
    act = Activity.find_by(id: self.activity_id)
    steps = ActivitiesStep.where(activity_id: act.id)
    steps.each do |s|
      puts s
    end
  end

end
