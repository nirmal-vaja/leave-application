module Api
  module V1
    class OrganizationsController < ApiController
      skip_before_action :doorkeeper_authorize!
      before_action :find_organization, only: [:update_status]      
      skip_before_action :set_tenant

      def index
        @organizations = Organization.all
        render json: {
          data: {
            organizations: @organizations
          },
          status: :ok
        }
      end

      def get_subdomains
        @subdomains = Organization.accepted.pluck(:subdomain)

        if @subdomains && Apartment.tenant_names.include?(params[:subdomain])

          @organization = Organization.find_by(subdomain: params[:subdomain])

          if @organization.accepted?
            render json: {
              status: :ok,
              data: {
                subdomains: @subdomains
              }
            }
          else
            render json: {
              data: {
                subdomains: @subdomains
              },
              message: "Your request will be approved in short time!",
              status: :unprocessable_entity
            }
          end
        else
          render json:
          {
            message: "Invalid subdomain",
            status: :unprocessable_entity
          }
        end
      end
    
      def create
        @organization = Organization.new(organization_params)
    
        if @organization.save
          current = Apartment::Tenant.current
          Apartment::Tenant.switch!(@organization.subdomain)
          user = User.new(
            first_name: @organization.name,
            last_name: "'s Admin",
            date_of_joining: Date.today,
            phone_number: "9898989898",
            email: params[:admin_email],
            password: params[:admin_password],
            admin: true
          )
          if user.save
            doorkeeper_application = Doorkeeper::Application.first
            Apartment::Tenant.switch!(current)
            render json: {
              message: "Organization has been created.",
              status: :created,
              data: {
                organization: @organization,
                doorkeeper_application: {
                  name: doorkeeper_application.name,
                  client_id: doorkeeper_application.uid,
                  client_secret: doorkeeper_application.secret
                }
              }
            }
          else
            render json: {
              message: user.errors.full_messages.join(' '),
              status: :unprocessable_entity
            }
          end
        else
          render json: {
            message: @organization.errors.full_messages.join(' '),
            status: :unprocessable_entity
          }
        end
      end

      def update_status
        if @organization.update(organization_params)
          render json: {
            data: {
              organization: @organization
            }, status: :ok
          }
        else
          render json: {
            message: @organization.errors.full_messages.join(' '),
            status: :unprocessable_entity
          }
        end
      end
    
      private
    
      def find_organization
        @organization = Organization.find_by_id(params[:id])
      end
    
      def organization_params
        params.require(:organization).permit(:name, :support_email, :contact_number, :city, :state, :country, :subdomain, :status)
      end
    end
  end
end
