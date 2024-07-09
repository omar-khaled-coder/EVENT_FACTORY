class CreateSpaces < ActiveRecord::Migration[7.1]
  def change
    create_table :spaces do |t|
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.string :title
      t.text :description
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.string :postal_code
      t.string :space_type
      t.integer :capacity
      t.json :amenities
      t.decimal :price_per_hour, precision: 10, scale: 2
      t.decimal :price_per_day, precision: 10, scale: 2
      t.date :start_date
      t.date :end_date
      t.boolean :is_hourly_available
      t.boolean :is_daily_available

      t.timestamps
    end
  end
end
