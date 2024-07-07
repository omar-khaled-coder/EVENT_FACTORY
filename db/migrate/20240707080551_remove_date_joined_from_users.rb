class RemoveDateJoinedFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :date_joined, :date
  end
end
