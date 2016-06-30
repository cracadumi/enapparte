class AddCreditCardToBookings < ActiveRecord::Migration
  def change
    add_reference :bookings, :credit_card, index: true, foreign_key: true
  end
end
