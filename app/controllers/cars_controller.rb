class CarsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_car, :only => [:show, :edit, :update, :destroy]

  def new
    @car = Car.new
    authorize! :create, @car
  end

  def create
    @car = Car.new(car_params) 
    if @car.save
      redirect_to @car
    else
      render 'new'
    end
  end

  def show
    authorize! :read, @car
  end

  def index
    @cars = Car.paginate(:page => params[:page], :per_page => 2)
    authorize! :read, @car
  end

  def edit
    authorize! :edit, @car
  end

  def update
    if @car.update(car_params)  
      redirect_to @car
    else 
      render :edit
    end
  end

  def destroy
    @car = Car.find(params[:id])
    authorize! :destroy, @car
    @car.destroy
    redirect_to cars_path
  end

 
  def available_vehicles
    session[:pick_up_date] = params[:pick_up_date]
    session[:drop_date] = params[:drop_date]
    @booked_vehicles = Car.joins(:bookings).where(:no_of_seates => params[:no_of_seates]).where("date(bookings.pick_up_date) BETWEEN ? AND ? OR date(bookings.drop_date) BETWEEN ? AND ? ", params[:pick_up_date] ,params[:drop_date],params[:pick_up_date] ,params[:drop_date])
    @all_vehicles = Car.where(:no_of_seates => params[:no_of_seates]) 
    @available_vehicles = @all_vehicles - @booked_vehicles
  end

  private
  def car_params
    params.require(:car).permit(:title, :no_of_seates, :cost_per_day, :image, :milage, :registration_no)
  end

  def set_car
    @car =  Car.find(params[:id])
  end
end
