class BookingsController < ApplicationController
require 'rubygems'
require 'active_merchant'

  before_filter :authenticate_user!
  before_filter :set_booking, :only => [:show, :payment, :destroy, :download, :fill_payment_detail]

  def new
    @booking = Booking.new
    @car = Car.find(params[:car_id])
  end
 
  def create
    @booking = current_user.bookings.new(booking_params)
    days = (session[:drop_date].to_date - session[:pick_up_date].to_date).to_i + 1
    @booking.total_cost = days * @booking.car.cost_per_day 
    @booking.pick_up_date = session[:pick_up_date]
    @booking.drop_date = session[:drop_date]
    if @booking.save
      session[:pick_up_date], session[:drop_date] = "", ""
      UserMailer.booking_email(current_user).deliver
      redirect_to fill_payment_detail_booking_path(@booking)
    else
      render 'new'
    end
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
  
  def download
    @car = @booking.car
    kit = PDFKit.new(render_to_string(:action => "download", :layout => false))
    send_data(kit.to_pdf, :filename => "booking.pdf", :type => "application/pdf") 
  end

  def show
    @car = @booking.car
  end

  def fill_payment_detail
  end

  def complete  
  amount = 1000
  ActiveMerchant::Billing::Base.mode = :test

  gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(:login => 'harsh90@grepruby.com',:password => 'HARSHsingh@123')
  credit_card = ActiveMerchant::Billing::CreditCard.new(
                :first_name         => 'dsfsdf',
                :last_name          => 'fdfd',
                :number             => '4242424242424242' ,
                :month              => 05,
                :year               => 2015,
                :verification_value => '123')
    if credit_card.valid?
      response = gateway.purchase(amount, credit_card)
      if response.success?
        puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
      else
        raise StandardError, response.message
      end
    end
  end

  private 
  def booking_params
    params.require(:booking).permit(:no_of_seates, :total_cost, :pick_up_date, :user_id, :car_id, :drop_date, :pick_up_location, :pick_up_time, :drop_location)
  end

  def set_booking
    @booking =  Booking.find(params[:id])
  end
end

