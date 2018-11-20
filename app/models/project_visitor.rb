class ProjectVisitor < ApplicationRecord
  belongs_to :project, counter_cache: true
end
