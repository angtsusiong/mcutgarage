class Activity < ApplicationRecord
  has_many :activities_steps
  has_many :steps, through: :activities_steps #, inverse_of: :activity
  accepts_nested_attributes_for :activities_steps, reject_if: :all_blank, allow_destroy: true
  has_many :project
  has_paper_trail
  validates :name, :default, :is_active, presence: true

  def add_step( step_name, priority, pub )
    s = Step.find_by(name: step_name.to_s)
    a_id = self.id
    ActivitiesStep.create(
      step_id: s.id,
      activity_id: a_id,
      priority: priority.to_i,
      public: pub)
  end

end
