class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id], accept: false)
    if @friendship.save
      flash[:notice] = 'Successfully friended'
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def accept
    @friendship = current_user.inverse_friendships.where(user_id: params[:id]).first
    @friendship.accept = true
    if @friendship.save
      flash[:notice] = 'Successfully friended'
    else
      flash[:alert] = @friendship.errors.full_messages.to_sentence
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @friendship = current_user.friendships.where(friend_id: params[:id]).first
    @friendship ||= current_user.inverse_friendships.where(user_id: params[:id]).first
    @friendship.destroy
    flash[:alert] = "Friendship destroyed"
    redirect_back(fallback_location: root_path)
  end
end
