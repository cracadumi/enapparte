class HomeController < ApplicationController
  def index
  end

  def contact
    contact = contact_params
    if current_user
      contact[:name] = current_user.full_name
      contact[:email] = current_user.email
      contact[:phone] = current_user.phone_number
      contact[:city] = current_user.addresses.first.try(:city)
    end
    UserMailer.contact_mail(contact).deliver_now
    render json: { msg: "success" }
  end

  private
    def contact_params
      params.require(:contact).permit(:user_id, :name, :email, :city, :phone, :message)
    end
end
