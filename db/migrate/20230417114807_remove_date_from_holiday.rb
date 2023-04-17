class RemoveDateFromHoliday < ActiveRecord::Migration[7.0]
  def change
    remove_column :holidays, :date, :datetime
  end
end
