FactoryGirl.define do
  factory :transaction do
    amount 1.5
    status "MyString"
    credit_card_id 1
    user_id 1
    booking_id 1
    payment_error "MyText"
  end
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
