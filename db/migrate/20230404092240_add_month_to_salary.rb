class AddMonthToSalary < ActiveRecord::Migration[7.0]
  def change
    add_column :salaries, :month, :string
    add_column :salaries, :travel_allowance, :integer
  end
end
