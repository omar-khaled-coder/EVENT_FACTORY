class EnsureCurrencyColumnInSpaces < ActiveRecord::Migration[7.1]
  def change
    unless column_exists?(:spaces, :currency)
      add_column :spaces, :currency, :string
    end
  end
end
