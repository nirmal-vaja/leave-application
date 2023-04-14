module Api
  module V1
    class RolesController < ApiController

      before_action :find_role, only: [:destroy]

      def index
        @roles = Role.pluck(:name)

        render json: {
          data: {
            roles: @roles
          },
          status: :ok
        }
      end

      def create
        @role = Role.new(role_params)

        if @role.save
          render json: {
            data: {
              role: @role
            },status: :created
          }
        else
          render json: {
            message: @role.errors.full_messages.join(', '),
            status: :unprocessable_entity
          }
        end
      end

      def destroy
        if @role.destroy
          render json: {
            message: "Role has been successfully deleted",
            status: :ok
          }
        else
          render json: {
            message: @role.errors.full_messages.join(', '),
            status: :unprocessable_entity
          }
        end
      end

      private

      def role_params
        params.require(:role).permit(:name)
      end

      def find_role
        @role = Role.find_by(id: params[:id])
      end
    end
  end
end