class AddTypeToLeave < ActiveRecord::Migration[7.0]
  def change
    add_column :leaves, :type, :integer
  end
end
