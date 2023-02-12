class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @genres = Genre.all
    @notifications = current_user.passive_notifications.all.where.not(visitor_id: current_user.id).page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
    @genres = Genre.all
  end
  
  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    flash[:notice] = "通知を削除しました"
  	redirect_to request.referer 
  end
end