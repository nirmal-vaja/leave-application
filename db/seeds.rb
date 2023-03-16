# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


current_tenant = Apartment::Tenant.current

Apartment::Tenant.switch! unless current_tenant == "public"

User.find_or_create_by(email: "superadmin@gmail.com") do |user|
  user.first_name = "Super"
  user.last_name = "Admin"
  user.date_of_joining = 4.years.ago
  user.phone_number = "9878987898"
  user.password = "superadmin123"
end

Doorkeeper::Application.create(name: "React Client", redirect_uri: "", scopes: "")

Apartment::Tenant.switch!(current_tenant)