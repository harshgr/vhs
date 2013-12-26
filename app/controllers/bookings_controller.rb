class BookingsController < ApplicationController
before_filter :authenticate_user! 

  def new
    @booking = Booking.new
    @car = Car.find(params[:car_id])
  end
 
  def create
    @booking = current_user.bookings.new(booking_params)
    if @booking.save
     @user = current_user
      UserMailer.booking_email(@user).deliver
      redirect_to @booking
    else
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end  

  def showindex
    
  end
  
  def index
    if current_user && current_user.isadmin 
      @bookings = Booking.all
    else
      @user = current_user
      @bookings = @user.bookings
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path
  end
  
  def gmap
    @booking =  Booking.find(params[:id])
  end
  
  

#  def search_vehicle
  #  if Booking.where("pick_up_date..drop_date AND no_of_seates ",{ params[:pick_up_date], params[:drop_date], params[:no_of_seates] })  
  #  render 'bookings/not_avaliable.html.erb'
  #   else
  #  render 'bookings/search_hvechile.html.erb'
  # end
# end

  private 
  def booking_params
    params.require(:booking).permit(:no_of_seates, :pick_up_date, :user_id, :car_id, :drop_date, :pick_up_location, :pick_up_time, :drop_location)
  end
  
end
