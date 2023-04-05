class CreateSalaries < ActiveRecord::Migration[7.0]
  def change
    create_table :salaries do |t|
      t.integer :basic_salary
      t.integer :dearness_allowance
      t.integer :house_rent_allowance
      t.integer :conveyance_allowance
      t.integer :medical_allowance
      t.integer :special_allowance
      t.integer :gross_salary_pm
      t.integer :ctc_salary_pm
      t.integer :net_salary

      t.timestamps
    end
  end
end
