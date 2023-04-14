class ChangeTypeToLeaveTypeInLeave < ActiveRecord::Migration[7.0]
  def change
    change_column(:leaves, :type, :leave_type)
  end
end
