class CarsController < ApplicationController

before_filter :authenticate_user!

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
    @car = Car.find(params[:id])
    authorize! :read, @car
  end

  def index
    @cars = Car.paginate(:page => params[:page], :per_page => 2)
  end

  def edit
    @car = Car.find(params[:id])
    authorize! :edit, @car
  end

  def update
    @car = Car.find(params[:id])
    if @car.update(car_params)  
      redirect_to @car
    else 
      render text:wrong
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to cars_path
  end

 
  def available_vehicles
  
  session[:pick_up_date] = params[:pick_up_date]
  session[:drop_date] = params[:drop_date]
  #params[:no_of_seates]
  
  #sql = "SELECT c.id, c.title FROM cars c INNER JOIN bookings b ON c.id = b.car_id WHERE c.no_of_seates = #{params[:no_of_seates]} AND b.pick_up_date BETWEEN '#{params[:pick_up_date]}' AND '#{params[:drop_date]}' OR b.drop_date BETWEEN '#{params[:pick_up_date]}' AND '#{params[:drop_date]}'"
  #Car.find_by_sql(sql)
  
  @booked_vehicles = Car.joins(:bookings).where(:no_of_seates => params[:no_of_seates]).where("date(bookings.pick_up_date) BETWEEN ? AND ? OR date(bookings.drop_date) BETWEEN ? AND ? ", params[:pick_up_date] ,params[:drop_date],params[:pick_up_date] ,params[:drop_date])
  
  @all_vehicles = Car.where(:no_of_seates => params[:no_of_seates]) 
   
  @available_vehicles = @all_vehicles - @booked_vehicles
  
  # @available_vehicles = Car.all
  #render :json => @available_vehicles
  #render :partial => "car"
    
  end

  private
  def car_params
    params.require(:car).permit(:title, :no_of_seates, :cost_per_day, :image, :milage, :registration_no)
  end
end
