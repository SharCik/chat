class MessagesController < ApplicationController

  before_filter :authenticate_user!

  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!

    @path = conversation_path(@conversation)
  end

  def delete

    @message = Message.find(params[:message_id])
    @conversation = Conversation.find(@message.conversation_id)
    @message.destroy!

    respond_to do |format|
      format.html {redirect_to conversation_path(@conversation)}
      format.js {}
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

end
