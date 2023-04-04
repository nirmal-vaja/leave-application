module Api
  module V1
    class BankInfosController < ApiController
      before_action :find_bank_info, only: [:update, :destroy]

      def create
        @bank_info = BankInfo.new(bank_info_params)
        @bank_info.user = current_user
        if @bank_info.save
          render json: {
            message: "Your bank details has been saved.",
            status: :created,
            data: {
              bank_info: @bank_info
            }
          }
        else
          render json: {
            message: @bank_info.errors.full_messages.join(', '),
            status: :unprocessable_entity
          }
        end
      end

      def update
        if @bank_info.update(bank_info_params)
          render json: {
            message: "Bank details has been updated",
            status: :ok,
            data: {
              bank_info: @bank_info
            }
          }
        else
          render json: {
            message: @bank_info.errors.full_messages.join(', '),
            status: :unprocessable_entity
          }
        end
      end
      
      private

      def find_bank_info
        @bank_info = BankInfo.find_by_id(params[:id])
      end

      def bank_info_params
        params.require(:bank_info).permit(:name, :account_number, :ifsc_code)
      end

    end
  end
end