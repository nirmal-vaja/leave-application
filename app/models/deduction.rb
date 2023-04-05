class Deduction < ApplicationRecord
  belongs_to :salary 

  after_create :calculate_total_deduction

  private

  def calculate_total_deduction
    total_deduction = professional_tax + tax_deducted_at_source + employee_provident_fund
    update(total_deduction: total_deduction)
  end
end
