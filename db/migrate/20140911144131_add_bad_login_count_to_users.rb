class AddBadLoginCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bad_login_count, :integer
  end
end
