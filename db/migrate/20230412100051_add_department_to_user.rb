class AddDepartmentToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :department, :string
    add_column :users, :designation, :string
  end
end
