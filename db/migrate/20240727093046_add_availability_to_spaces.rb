class AddAvailabilityToSpaces < ActiveRecord::Migration[7.1]
  def change
    add_column :spaces, :available_from, :time
    add_column :spaces, :available_to, :time
    add_column :spaces, :minimum_rental_duration, :integer
  end
end
