class Transaction < ActiveRecord::Base
	serialize :payment_error, Hash
end

# == Schema Information
#
# Table name: transactions
#
#  id             :integer          not null, primary key
#  amount         :float
#  status         :string
#  credit_card_id :integer
#  user_id        :integer
#  booking_id     :integer
#  payment_error  :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
