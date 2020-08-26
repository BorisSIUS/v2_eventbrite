class ArchivedEventController < ApplicationController
  before_action :authenticate_web_master

  def index
    @events = Event.where(promoted: false)
  end

  private

  def authenticate_web_master
    unless current_user.web_master
      flash[:danger] = "Page interdite"
      redirect_to new_user_session_path
    end
  end  
end
