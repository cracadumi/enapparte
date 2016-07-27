class ChangeColumnStatusToBooking < ActiveRecord::Migration
  def change
  	change_column :bookings, :status, :integer, default: 2
  end
end
