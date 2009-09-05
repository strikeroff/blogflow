class UserSessionsController < ApplicationController
   before_filter :require_no_user, :only => [:new, :create]
    before_filter :require_user, :only => [:destroy, :not_authorized ]
#    layout "users"

    def new
      @user_session = UserSession.new
    end

    def create
      @user_session = UserSession.new(params[:user_session])
      if @user_session.save


        redirect_back_or_default root_url
      else
          flash[:error] = "flashes.user_session.created"
        render :action => :new
      end
    end

    def destroy
      current_user_session.destroy
      flash[:notice] = "Вы покинули систему"
      redirect_to root_url
    end
end
