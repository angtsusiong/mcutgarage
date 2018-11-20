class SetDefaultValueToActivity < ActiveRecord::Migration[5.2]
  def change
    change_column_default(
      :activities,
      :default,
      form: nil,
      to: false)

    change_column_default(
      :activities,
      :is_active,
      form: nil,
      to: false)
  end
end
