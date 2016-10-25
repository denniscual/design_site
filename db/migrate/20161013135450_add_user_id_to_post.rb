class AddUserIdToPost < ActiveRecord::Migration[5.0]
  def change
    # this will add a user id column on the posts table and the field type is integer
    add_column :posts, :user_id, :integer
  end
end
