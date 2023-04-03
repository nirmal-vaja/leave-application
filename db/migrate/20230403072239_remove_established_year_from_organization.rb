class RemoveEstablishedYearFromOrganization < ActiveRecord::Migration[7.0]
  def change
    remove_column :organizations, :established_year, :datetime
    remove_column :organizations, :website_url, :string
    remove_column :organizations, :address, :string
    remove_column :organizations, :type, :string
    remove_column :organizations, :description, :text
  end
end
