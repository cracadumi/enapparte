class Booking < ActiveRecord::Base
  belongs_to :show
  belongs_to :user
  belongs_to :address, class_name: 'Address'
  belongs_to :payment_method
  belongs_to :credit_card
  has_one    :review
  has_many   :ratings, through: :review

  just_define_datetime_picker :date
  just_define_datetime_picker :paid_on
  just_define_datetime_picker :paid_out_on

  before_save :set_payout_value
  before_save :change_booking_status

  alias_method :name, :id
  
  enum status: { confirmed: 1, pending: 2, canceled: 3, expired: 4 }

  def set_payout_value
    if price.present?
      self.payout = (price/ENV['COMMISSION'].to_f).round(2)
    end
  end

  def change_status status
    if self.update status: status
      case status
      # accept
      when 1, 'confirmed'
        self.update_attributes(
          payment_received?: true,
          paid_out_on: Time.new
        )
        PerformerMailer.booking_accepted(self).deliver_now
        UserMailer.booking_accepted(self).deliver_now
      # cancel
      when 3, 'canceled'
        PerformerMailer.booking_cancelled(self).deliver_now
        UserMailer.booking_cancelled(self).deliver_now
      end
    end
  end

  def change_booking_status
    if status_changed?
      case status
      when 1, 'confirmed'
        response = Booking.booking_payment((price.to_f*100), user.customer_id)
        if response == 'succeeded'
          Transaction.create(amount: price.to_f, status: "Success", credit_card_id: credit_card_id, user_id: user_id, booking_id: id)
          UserMailer.booking_created(self).deliver_now
          PerformerMailer.booking_created(self).deliver_now
        else
          Transaction.create(amount: price.to_f, status: "Fail", credit_card_id: credit_card_id, user_id: user_id, booking_id: id, payment_error: response)
          self.status = 'pending'
        end
      when 2, 'pending'
      when 3, 'canceled'
        self.credit_card_id = nil
      when 4, 'expired'
        self.credit_card_id = nil
      end
    end
  end

  def self.check_expired
    Booking.where("status = 'pending' and date > ?", 48.hours.ago).update_all status: 4
  end

  def self.booking_payment(price, customer_id)
    charge = Stripe::Charge.create(amount: price.to_i, currency: 'eur', customer: customer_id)
    return charge.status == 'succeeded' ? 'succeeded' : "#{charge.type}-#{charge.message}"
  end
end

# == Schema Information
#
# Table name: bookings
#
#  id                :integer          not null, primary key
#  status            :integer          default(2)
#  date              :datetime
#  spectators        :integer
#  price             :float
#  message           :text
#  payout            :float
#  payment_received? :boolean
#  payment_sent?     :boolean
#  paid_on           :datetime
#  paid_out_on       :datetime
#  show_id           :integer
#  user_id           :integer
#  address_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  payment_method_id :integer
#  credit_card_id    :integer
#
# Indexes
#
#  index_bookings_on_address_id         (address_id)
#  index_bookings_on_credit_card_id     (credit_card_id)
#  index_bookings_on_payment_method_id  (payment_method_id)
#  index_bookings_on_show_id            (show_id)
#  index_bookings_on_user_id            (user_id)
#
# Foreign Keys
#
#  fk_rails_3e4624132d  (credit_card_id => credit_cards.id)
#  fk_rails_f65e591682  (payment_method_id => payment_methods.id)
#
