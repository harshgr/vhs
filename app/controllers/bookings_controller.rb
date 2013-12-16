class BookingsController < ApplicationController


  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params) 
  if @booking.save
    redirect_to @booking
  else
    render 'new'
  end
  end

  
  private
  def booking_params
    params.require(:booking).permit(:no_of_seates, :pick_up_location, :pick_up_time, :drop_location, :date_of_booking, :no_of_days, :price)
  end
  
end
