module Api
  module V1
    class UsersController < Api::BaseController
      before_action :authenticate_user!, except: [:search]

      def search
        @users = UserSearchService.new(role: :performer,
                                       start_at: params[:start_at],
                                       stop_at: params[:stop_at],
                                       art_id: params[:art_id])
                                  .results
        respond_with :api, :v1, @users
      end

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
        params.require(:user)
              .permit(:gender, :firstname, :surname, :dob, :phone_number, :bio,
                      :activity, :email, :password, :password_confirmation,
                      addresses_attributes: [:id, :country, :latitude, :street,
                                             :city, :longitude, :is_primary,
                                             :state, :postcode],
                      picture_attributes: [:src],
                      payment_methods_attributes: [:id, :user_id, :stripe_token,
                                                   :last4],
                      language_ids: [], showcases_attributes: [:id, :kind, :url]
                     )
      end
    end
  end
end
