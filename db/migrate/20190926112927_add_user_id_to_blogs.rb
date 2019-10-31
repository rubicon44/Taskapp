class AddUserIdToBlogs < ActiveRecord::Migration[6.0]
  # def change
  # end

  def up
    execute 'DELETE FROM blogs;'
    add_reference :blogs, :user, null: false, index: true
  end

  def down
    remove_reference :blogs, :user, index: true
  end
end
