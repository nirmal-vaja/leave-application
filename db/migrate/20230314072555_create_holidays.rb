class CreateHolidays < ActiveRecord::Migration[7.0]
  def change
    create_table :holidays do |t|
      t.datetime :date
      t.string :occasion

      t.timestamps
    end
  end
end
