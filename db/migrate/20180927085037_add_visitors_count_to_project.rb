# -*- coding: utf-8 -*-
class AddVisitorsCountToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :project_visitors_count, :integer, :default => 0

#    Project.pluck(:id).each do |i|
#      Project.reset_counters(i, :project_visitors) # 全部重算一次
#    end
  end
end
