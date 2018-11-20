# -*- coding: utf-8 -*-
@poc = Step.create!(name: 'POC')
(1..8).each do |n|
  RequirementsStep.create(step_id: 1, requirement_id: n, priority: n)
end

@pos = Step.create!(name: 'POS')
(9..12).each do |n|
  RequirementsStep.create(step_id: 2, requirement_id: n, priority: n)
end

@pob = Step.create!(name: 'POB')
(13..18).each do |n|
  RequirementsStep.create(step_id: 3, requirement_id: n, priority: n)
end

puts "seeds 006_steps: Create Steps POC POS POB."

@act = Activity.new(name: '預設活動', default: true, is_active: true)

@act.save
ActivitiesStep.create(activity_id: 1,step_id: 1, priority: 1, public: true)
ActivitiesStep.create(activity_id: 1,step_id: 2, priority: 2, public: false)
ActivitiesStep.create(activity_id: 1,step_id: 3, priority: 3, public: false)

puts "seeds 007_activity: Create Default Activity"
