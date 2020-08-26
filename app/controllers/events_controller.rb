require 'date'
class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]
  before_action :authenticate_admin, only: [:edit, :update]


  def index
    @user = current_user
    @events = Event.where(promoted: true)
  end

  def new
    @event = Event.new    
  end
  
  def create
    puts params
    @event = Event.new(post_params)
    @event.administrator = current_user
    @event.scene.attach(params[:scene])

    if @event.save && @event.scene.attached?
      redirect_to event_path(@event.id)
    else
      render :new
    end
    
  end

  
  def show
    @success = false
    @id = params[:id]
    @event = Event.find(params[:id])
    @admin = @event.administrator
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(post_params)
      @event.scene.attach(params[:scene]) if params[:scene]
      render :show
    else
      render :edit
    end
  end
  
  def destroy
    Event.find(params[:id]).destroy
    redirect_to :root
  end

  private

  def post_params
    post_params = params.require(:event).permit(:title, :start_date, :description, :duration, :price, :location)
  end
  
  def authenticate_admin
    unless current_user == Event.find(params[:id]).administrator || current_user.web_master
      flash[:danger] = "Cette evenement n'est pas à vous"
      redirect_to new_user_session_path
    end
  end

end
