class RenameTypeToLeaveType < ActiveRecord::Migration[7.0]
  def change
    rename_column :leaves, :type, :leave_type
  end
end
