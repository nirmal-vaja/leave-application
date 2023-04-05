module Api
  module V1
    class SalariesController < ApiController

      def create
        @salary = Salary.new(salary_params)
        @deduction = @salary.build_deduction(deduction_params)
        if @salary.save
          render json: {
            message: "Salary has been created",
            status: :created,
            data: {
              salary: @salary,
              deduction: @deduction
            }
          }
        else 
          render json: {
            message: @salary.errors.full_messages.join(', '),
            status: :unprocessable_entity
          }
        end
      end

      private

      def salary_params
        params.require(:salary).permit(:basic_salary, :dearness_allowance, :house_rent_allowance, :conveyance_allowance, :medical_allowance, :special_allowance, :user_id)
      end

      def deduction_params
        params.require(:deduction).permit(:professional_tax, :tax_deducted_at_source, :employee_provident_fund)
      end
    end
  end
end