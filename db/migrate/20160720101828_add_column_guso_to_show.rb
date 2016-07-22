class AddColumnGusoToShow < ActiveRecord::Migration
  def change
    add_column :shows, :guso, :float
  end
end
