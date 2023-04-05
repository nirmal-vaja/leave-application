class CreateDeductions < ActiveRecord::Migration[7.0]
  def change
    create_table :deductions do |t|
      t.integer :professional_tax
      t.integer :tax_deducted_at_source
      t.integer :employee_provident_fund
      t.integer :total_deduction
      t.references :salary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
