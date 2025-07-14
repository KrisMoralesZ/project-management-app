class AddFieldsToArtifacts < ActiveRecord::Migration[8.0]
  def change
    add_reference :artifacts, :creator, null: false, foreign_key: { to_table: "users" }
    add_reference :artifacts, :assignee, null: false, foreign_key: { to_table: "users" }
    add_column :artifacts, :status, :integer, default: 0
  end
end
