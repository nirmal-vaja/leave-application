class AddPanNumberToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pan_number, :string
  end
end
