class Api::V1::UsersController < Api::BaseController

  def show
    @user = current_user
    respond_with :api, :v1, @user
  end

  def update
    @user = current_user
    @user.update_attributes user_params
    respond_with :api, :v1, @user
  end

  private

  def user_params
    params.require(:user).permit(:gender, :firstname, :surname, :dob, :phone_number, :language_id, :bio, :activity, :email, :password, :password_confirmation, addresses_attributes: [:id, :country, :state, :postcode, :city, :street, :is_primary, :latitude, :longitude], picture_attributes: [:src], payment_methods_attributes: [:user_id, :stripe_token, :last4])
  end

end
