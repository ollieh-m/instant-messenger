# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "messages/#{current_user}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  def speak(data)
    #when the client calls App.chat.speak this action is triggered, broadcasting on the messages stream so subscribed clients receive the message
    ActionCable.server.broadcast("messages/#{data['receiver']}",
      message: render_message(data['message']),
      sender: current_user)
  end
  
  private
  
  def render_message(message)
    ApplicationController.render(partial: 'messages/message',
                                 locals: { message: message, sender: User.find(current_user).email })
  end
    
end
