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
    @cars = Car.all
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
    @available_vehicles = Car.all
    #render :json => @available_vehicles
    render :partial => "car"
  end

  private
  def car_params
    params.require(:car).permit(:title, :no_of_seates, :image, :milage, :registration_no)
  end
end
