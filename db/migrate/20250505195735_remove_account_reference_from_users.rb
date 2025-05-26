class RemoveAccountReferenceFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_reference :users, :account, foreign_key: true
  end
end
