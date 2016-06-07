class RemoveArtIdFromShows < ActiveRecord::Migration
  def change
    remove_column :shows, :art_id
  end
end
