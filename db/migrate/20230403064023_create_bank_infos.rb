class CreateBankInfos < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_infos do |t|
      t.string :name
      t.string :account_number
      t.string :ifsc_code
      t.string :pan_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
