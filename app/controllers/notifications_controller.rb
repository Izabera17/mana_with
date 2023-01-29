class NotificationsController < ApplicationController
  def index
    @genres = Genre.all
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
      #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
    notifications = @notifications.where.not(visitor_id: current_user.id)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
  
  def destroy_all
    #通知を全削除
    @notifications = current_user.passive_notifications.destroy_all
    flash[:notice] = "通知を削除しました"
  	redirect_to request.referer 
  end
end
