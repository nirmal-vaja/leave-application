class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations do |t|
      t.string :name
      t.datetime :established_year
      t.text :address
      t.string :support_email
      t.string :contact_number
      t.string :type
      t.string :city
      t.string :state
      t.string :country
      t.text :description
      t.string :website_url

      t.timestamps
    end
  end
end
