class Api::V1::BookingsController < Api::BaseController

  def create
    @booking = current_user.bookings.build(booking_params)
    if @booking.valid?
      #response = Booking.booking_payment((@booking.price*100), current_user.customer_id)
      #if response == 'succeeded'
      #  @booking.status = 'confirmed'
      if @booking.save
        UserMailer.booking_created(@booking).deliver_now
        PerformerMailer.booking_created(@booking).deliver_now
        render json: {message: "Booking has been saved successfully. You will receive an confirmation email within 48 hrs.", success: true }
      else
        render json: {message: "Error in creating booking. Please try again later.", success: false }
      end
      #respond_with :api, :v1, @booking
      #else
      #  render json: {error: "#{response}", success: false }
      #end
    end
  end

  # def update
  #   @booking = current_user.bookings.find(params[:id])
  #   @booking.update(booking_params)
  #   respond_with :api, :v1, @booking
  # end

  def change_status
    @booking = current_user.show_bookings.find(params[:id])
    @booking.change_status(params[:booking][:status])
    respond_with :api, :v1, @booking
  end

  def index
    if params[:reservation]
      @bookings = current_user.bookings
    else
      @bookings = current_user.show_bookings
    end
    respond_with :api, :v1, @bookings
  end

  def apply_coupon
    puts params
    if params[:booking][:coupon] && params[:booking][:coupon] == 'EARLYBIRD'
      render :json => { success: true }
    else
      render :json => { success: false }
    end
  end

  # def destroy
  #   @booking = current_user.bookings.find(params[:id])
  #   @booking.destroy
  #   respond_with :api, :v1, @booking
  # end

  private

  def booking_params
    params.require(:booking).permit(:date, :spectators, :price, :message, :show_id, :user_id, :address_id, :status, :credit_card_id)
  end

end
