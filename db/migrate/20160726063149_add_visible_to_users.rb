class AddVisibleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visible, :boolean, default: false
  end
end
