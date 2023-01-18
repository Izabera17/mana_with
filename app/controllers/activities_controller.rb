class ActivitiesController < ApplicationController
  def index
    @activities = current_user.active_notifications.page(params[:page]).per(20)
  end
  
   def destroy_all
    #通知を全削除
    @activities = current_user.passive_notifications.destroy_all
  	redirect_to activities_path
  end
end
