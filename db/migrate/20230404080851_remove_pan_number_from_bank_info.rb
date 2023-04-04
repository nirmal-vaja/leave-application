class RemovePanNumberFromBankInfo < ActiveRecord::Migration[7.0]
  def change
    remove_column :bank_infos, :pan_number, :string
  end
end
