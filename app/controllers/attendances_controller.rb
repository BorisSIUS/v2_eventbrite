class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def new
    @event = Event.find(params[:event_id])
    if @event.is_free?
    Attendance.create(attendant: current_user, attended_event: Event.find(params[:event_id]), stripe_customer_id: "FREE")
    redirect_to event_path(@event.id)
    end
  end

  def index
    @event = Event.find(params[:event_id])
    @attendances = Attendance.where(attended_event: Event.find(params[:event_id]))
  end


end
