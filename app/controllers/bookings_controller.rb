class BookingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_booking, :only => [:show, :payment, :destroy, :gmap]

  def new
    @booking = Booking.new
    @car = Car.find(params[:car_id])
  end
 
  def create
  
    @booking = current_user.bookings.new(booking_params)
    
    @days = (session[:drop_date].to_date - session[:pick_up_date].to_date).to_i
    @days = @days +1  
    @booking.total_cost = @days * @booking.car.cost_per_day 

    @booking.pick_up_date = session[:pick_up_date]
    @booking.drop_date = session[:drop_date]
    if @booking.save
      session[:pick_up_date], session[:drop_date] = "", ""
      UserMailer.booking_email(current_user).deliver
      redirect_to payment_booking_path(@booking)
    else
      render 'new'
    end
  end

  def show
    @car = @booking.car
  end  

  def payment
  end
  
  def index
    
    if current_user && current_user.isadmin
      @bookings = Booking.includes(:car).paginate(:page => params[:page], :per_page => 8)
    else
      @bookings = current_user.bookings.includes(:car).paginate(:page => params[:page], :per_page => 8)
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end
  
  def gmap
  end
  
  private 
  def booking_params
    params.require(:booking).permit(:no_of_seates, :total_cost, :pick_up_date, :user_id, :car_id, :drop_date, :pick_up_location, :pick_up_time, :drop_location)
  end

  def set_booking
    @booking =  Booking.find(params[:id])
  end
  
end
