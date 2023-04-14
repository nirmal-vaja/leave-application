class RemovePanNumberFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :pan_number, :string
  end
end
