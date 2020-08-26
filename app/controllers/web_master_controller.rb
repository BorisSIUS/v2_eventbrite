class WebMasterController < ApplicationController
  before_action :authenticate_web_master, # only: [:edit, :update]

  def index
    puts "$" * 10
    puts params[:show]
    @new_events = Event.where(promoted: nil)
    puts "$" * 10

  end

  def create
    puts params
    puts params.keys[2]
    puts params.values[2]
    user = User.find_by(email: params.values[2])
    case params.keys[2]
    when "show"
      redirect_to member_path(user.id)
    when "delete"
      user.destroy
    when "edit"
      redirect_to edit_member(user.id)
    when ""
    end
  end

  private

  def authenticate_web_master
    unless current_user.web_master
      flash[:danger] = "Page interdite"
      redirect_to new_user_session_path
    end
  end

end
