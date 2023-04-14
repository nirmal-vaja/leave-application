class AddPanNumberToBankInfo < ActiveRecord::Migration[7.0]
  def change
    add_column :bank_infos, :pan_number, :string
  end
end
