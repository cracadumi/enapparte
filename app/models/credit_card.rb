class CreditCard < ActiveRecord::Base
  belongs_to :user

  def set_default!
    user.credit_cards.update_all(default: false)
    self.update(default: true)
  end
end