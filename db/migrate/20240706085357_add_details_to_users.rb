class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :date_joined, :date
    add_column :users, :profile_picture, :string
    add_column :users, :govt_id_picture, :string
    add_column :users, :phone_number, :string
  end
end
