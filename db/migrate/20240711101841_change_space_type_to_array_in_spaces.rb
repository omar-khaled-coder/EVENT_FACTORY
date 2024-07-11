class ChangeSpaceTypeToArrayInSpaces < ActiveRecord::Migration[7.1]
  def change
    execute <<-SQL
      ALTER TABLE spaces
      ALTER COLUMN space_type SET DATA TYPE text[]
      USING string_to_array(space_type, ',');
    SQL
    change_column_default :spaces, :space_type, []
  end
end
