class AddUserIdToInfomations < ActiveRecord::Migration
  def change
    add_column :infomations, :user_id, :string
  end
end
