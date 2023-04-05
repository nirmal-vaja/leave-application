class Salary < ApplicationRecord
  belongs_to :user
  has_one :deduction, dependent: :delete

  after_commit :update_gross_and_ctc_salary

  private

  def update_gross_and_ctc_salary
    gross_salary = basic_salary + dearness_allowance + house_rent_allowance + conveyance_allowance + medical_allowance + special_allowance 
    ctc_salary = travel_allowance ? gross_salary + travel_allowance : gross_salary

    net_salary = gross_salary + deduction.total_deduction 
    if gross_salary_pm != gross_salary || ctc_salary_pm != ctc_salary || net_salary != net_salary
      update(
        gross_salary_pm: gross_salary,
        ctc_salary_pm: ctc_salary,
        net_salary: net_salary
      )
    end
  end
end
