class MembersController < ApplicationController
    before_action :authenticate_user!, only: [:show]
    before_action :authenticate_profile, only: [:edit, :update]
    before_action :authenticate_web_master, only: [:index]

    def show
        @user = User.find(params[:id])
        @events = @user.administrated_events
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        @user.avatar.attach(params[:avatar]) if params[:avatar]
        if @user.update(post_params)
            render :show
        else
            render :edit
        end
    end

    def index
        @users = User.all
    end

    def is_profile_owned_by_user?    
        if params[:id] == current_user.id
            return true 
        else
            return false
        end
    end

    private

    def post_params
        post_params = params.require(:user).permit(:first_name, :last_name, :description)
    end

    def authenticate_profile
        unless current_user == User.find(params[:id]) || current_user.web_master
          flash[:danger] = "Ce profil n'est pas à vous"
          redirect_to new_user_session_path
        end
    end


    def authenticate_web_master
        unless current_user.web_master
          flash[:danger] = "Ce profil n'est pas à vous"
          redirect_to new_user_session_path
        end
    end

end