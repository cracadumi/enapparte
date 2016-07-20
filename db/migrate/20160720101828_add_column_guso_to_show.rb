class AddColumnGusoToShow < ActiveRecord::Migration
  def change
    add_column :shows, :guso, :float, default: 0.0
  end
end
