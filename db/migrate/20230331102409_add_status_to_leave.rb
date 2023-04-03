class AddStatusToLeave < ActiveRecord::Migration[7.0]
  def change
    add_column :leaves, :status, :integer, default: 0
  end
end
