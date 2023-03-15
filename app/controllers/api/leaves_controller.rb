class LeavesController < ApplicationController
  before_action :find_leave, only: [:show, :update, :destroy]

  def index
    @leaves = Leave.all
    render json: {
      data: {
        leaves: @leaves
      }
    }
  end

  def show
    if @leave
      render json: {
        data: {
          leave: @leave
        },
        status: true
      }
    else
      render json: {
        message: "Leave not found",
        status: false
      }
    end
  end

  def create
    @leave = Leave.new(leave_params)
    @leave.user = current_user
    if @leave.save
      render json: {
        message: "Leave has been requested, wait for the approval!",
        status: true,
        data:{
          leave: @leave
        }
      }
    else
      render json: {
        message: @leave.errors.full_messages.join(' ')
        status: false
      }
    end
  end

  def update
    if @leave
      if @leave.update(leave_params)
        render json: {
          message: "Leave has been updated, wait for the approval",
          status: true,
          data: {
            leave: @leave
          }
        }
      else
        render json: {
          message: @leave.errors.full_messages.join(' '),
          status: false
        }
      end
    else
      render json: {
        message: "Leave not found"
        status: false
      }
    end
  end

  def destroy
    if @leave
      if @leave.destroy
        render json: {
          message: "Leave has been permanently removed.",
          status: true
        }
      else
        render json: {
          message: @leave.errors.full_messages.join(' '),
          status: false
        }
      end
    else
      render json: {
        message: "Leave not found",
        status: false
      }
    end
  end

  private

  def find_leave
    @leave = Leave.find_by_id(params[:id])
  end

  def leave_params
    params.require(:leave).permit(:start_date, :end_date, :subject, :description)
  end
end