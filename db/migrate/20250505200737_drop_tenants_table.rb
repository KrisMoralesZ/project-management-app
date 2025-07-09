class DropTenantsTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :tenants do |t|
      t.string "name"
      t.string "subdomain"
      t.string "plan"
      t.timestamps
    end
  end
end
