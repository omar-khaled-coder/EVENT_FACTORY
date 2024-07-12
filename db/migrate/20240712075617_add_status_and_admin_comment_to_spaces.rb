class AddStatusAndAdminCommentToSpaces < ActiveRecord::Migration[7.1]
  def change
    add_column :spaces, :status, :string
    add_column :spaces, :admin_comment, :text
  end
end
