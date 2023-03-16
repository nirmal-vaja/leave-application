module Api
  module V1
    class HolidaysController < ApiController
      before_action :find_holiday, only: [:show, :update, :destroy]
    
      def index
        @holidays = Holiday.all
    
        render json: {
          data: {
            holidays: @holidays
          },
          status: true
        }
      end
    
      def show
        if @holiday
          render json: {
            data: {
              holiday: @holiday
            },
            status: true
          }
        else
          render json: {
            message: "No holidays found",
            status: false
          }
        end
      end
    
      def create
        @holiday = Holiday.new(holiday_params)
        
        if @holiday.save
          render json: {
            mesage: "Holiday has been created.",
            data: {
              holiday: @holiday
            },
            status: true
          }
        else
          render json: {
            message: @holiday.errors.full_messages.join(' '),
            status: false
          }
        end
      end
    
      def update
        if @holiday
          if @holiday.update(holiday_params)
            render json: {
              message: "Holiday has been updated",
              status: true,
              data: {
                holiday: @holiday
              }
            }
          else
            render json: {
              message: @holiday.errors.full_messages.join(' '),
              status: false
            }
          end
        else
          render json: {
            message: "Holiday not found",
            status: false
          }
        end
      end
    
      def destroy
        if @holiday
          if @holiday.destroy
            render json: {
              message: "The holiday data has been removed",
              status: true
            }
          else
            render json: {
              message: @holiday.errors.full_messages.join(' '),
              status: false
            }
          end
        else
          render json: {
            message: "Holiday not found",
            status: false
          }
        end
      end
    
      private
    
      def find_holiday
        @holiday = Holiday.find_by_id params[:id]
      end
    
      def holiday_params
        params.require(:holiday).permit(:date, :occasion)
      end
    end
  end
end
