class AddPoliciesAcceptedToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :policies_accepted, :boolean, default: false, null: false
  end
end
