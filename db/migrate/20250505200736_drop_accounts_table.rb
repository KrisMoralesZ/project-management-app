class DropAccountsTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :accounts do |t|
      t.string "name"
      t.string "subdomain"
      t.timestamps
    end
  end
end
