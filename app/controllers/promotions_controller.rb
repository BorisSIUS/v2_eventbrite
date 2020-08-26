class PromotionsController < ApplicationController
    before_action :authenticate_web_master

  
    def index
        @events = Event.where(promoted: nil)
    end
  
    def edit
        puts params[:event_id]
        event = Event.find(params[:event_id])
        promotion_up(event)
        event.update(promoted: true)
        redirect_to promotions_path
    end

    def destroy
        event = Event.find(params[:event_id])
        promotion_down(event)
        event.update(promoted: false)
        redirect_to promotions_path
    end
    
    private
  
    def authenticate_web_master
      unless current_user.web_master
        flash[:danger] = "Page interdite"
        redirect_to new_user_session_path
      end
    end

    def promotion_up(event)
      UserMailer.promotion_up_email(event).deliver_now
    end

    def promotion_down(event)
      UserMailer.promotion_down_email(event).deliver_now
    end
  
  end
  