class Step < ApplicationRecord
  has_many :activities_steps
  has_many :activity, through: :activities_steps
  has_many :requirements_steps
  has_many :requirements, through: :requirements_steps #, inverse_of: :step
  accepts_nested_attributes_for :requirements_steps, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
  has_paper_trail
  def add_requirement(requirement_name)
    r = Requirement.find_by(name: requirement_name.to_s)
    s_id = self.id
    RequirementsStep.create(step_id: s_id, requirement_id: r.id)
  end

  def archive
    s_id = self.id
    reqs = RequirementsStep.where(step_id: s_id)

    reqs.each do |r|
      Requirement.find(r.requirement_id).as_json(only: [:name, :datatype, :desc, :minimum, :maximum])
    end



  end

end
