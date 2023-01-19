class HomesController < ApplicationController
  def top
  end

  def home
    @genres = Genre.all
    @post_learnings = PostLearning.all.order(created_at: :desc).limit(5)
  end
end






# <div class="sidebar-menu">
#         <p>　フォロー ・ フォロワー</p>
#           <div class="sidebar-list">
#             <ul>
#                 <% if current_user.id == @user.id%>
#                   <li>
#                     <%= link_to "フォロー ", {controller: :users,action: :follow_list,user_id: @user.id}, method: :get %>
#                     <%= @user.follow_count %>人
#                   </li>
#                   <li>
#                     <%= link_to "フォロワー ", {controller: :users,action: :follower_list,user_id: @user.id}, method: :get%>
#                     <%= @user.followers_count %>人
#                   </li>
#                 <% end %>
#               <li>
#                 <%= render 'shared/follow' %>  
#               </li>
#               <li>
#                 <% if user_signed_in? && current_user.id == @user.id %>
#                   <%= link_to (activities_path) do %>
#                     <% if unchecked_notifications.any?%>
#                       <p>アクティビティ通知（未読あり）</p>
#                     <% else %>
#                       <p>アクティビティ通知</p>
#                     <% end %>
#                   <% end %>
#                 <% end %>
#               </li>
#             </ul>
#           </div>
#         </div>
      
        <div class="sidebar-content">
          <% unless current_user.id == @user.id %>
            <% if (current_user.followed_by? @user) && (@user.followed_by? current_user) %>
              <div class="sidebar-menu">
                <p>　DM</p>
                <div class="sidebar-list">
                  <% if @isRoom == true %>
                    <p class="user-show-room"><a href="/rooms/<%= @roomId %>" class="btn btn-primary btn-lg">チャットへ</a>
                  <% else %>
                    <%= form_for @room do |f| %>
                      <%= fields_for @entry do |e| %>
                        <%= e.hidden_field :user_id, value: @user.id %>
                      <% end %>
                      <%= f.submit "チャットを始める", class:"btn btn-primary btn-lg user-show-chat"%>
                    <% end %>
                  <% end %>
                </div>
              </div>
            <% end %>
          <% end %>
        </div>