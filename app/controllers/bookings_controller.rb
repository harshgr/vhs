class BookingsController < ApplicationController
before_filter :authenticate_user! 

  def new
    @booking = Booking.new
  end
 
       

  def create
 
  @booking = Booking.new(booking_params) 
  @booking = 
  if @booking.save
    redirect_to @booking
  else
    render 'new'
  end
  end

  def show
    @booking = Booking.find(params[:id])
  end  

  def index
    @bookings = Booking.all
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end


  private
  def booking_params
    params.require(:booking).permit(:no_of_seates, :pick_up_date, :drop_date, :pick_up_location, :pick_up_time, :drop_location)
  end
  
end
