class AddStartDateToHoliday < ActiveRecord::Migration[7.0]
  def change
    add_column :holidays, :start_date, :datetime
    add_column :holidays, :end_date, :datetime
  end
end
