module UsersHelper
  def conversation_interlocutor(conversation)
    conversation.recipient == current_user ? conversation.sender : conversation.recipient
  end

  def user_online?(useru , user)
  	on_users = useru.online_now
  	mass = Array.new
  	on_users.each do |us|
  		mass << us.id
  	end
  	image_tag('purpure.png', size:"10x10", :alt => "Online") if mass.include?(user.id)
  end
end
