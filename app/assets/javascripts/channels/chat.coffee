chatWindow = {
  thread: '<div class="thread"></div>'
  send: '<input class="send" type=text></input>'
  close: '<button class="close-chat">CLOSE CHAT</button>'
}

userArrays = {}

App.chat = App.cable.subscriptions.create "ChatChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    if userArrays[data.sender]
      userArrays[data.sender].push(data)
    else
      userArrays[data.sender] = [data]
    
    if $("##{data.sender}.chat-window .thread").length == 0
      $('#' + data.sender + '.user').append('<span>| Message Received |</span>')
    else
      $('#' + data.sender + '.chat-window .thread').append(data.message)

  speak: (receiver,msg) ->
    @perform 'speak', receiver: receiver, message: msg
    
$(document).on 'click', '.open-chat', (event) ->
    $('#' + event.target.id + '.chat-window').append(chatWindow.thread, chatWindow.send, chatWindow.close)
    if userArrays[event.target.id]
      for message in userArrays[event.target.id]
        $('#' + event.target.id + '.chat-window .thread').append(message.message)
        
$(document).on 'keyup', '.send', (event) ->
    if event.keyCode == 13
      recipientId = event.target.parentElement.id
      message = '<p><b>You</b>:' + event.target.value + '</p>'
      $('#' + recipientId + '.chat-window .thread').append(message)
      if userArrays[recipientId]
        userArrays[recipientId].push({message: message, sender: 'You'})
      else
        userArrays[recipientId] = [{message: message, sender: 'You'}]
      
      App.chat.speak(event.target.parentElement.id, event.target.value)
      event.target.value = ''
      event.preventDefault()
      
$(document).on 'click', '.close-chat', (event) ->
   event.target.parentElement.innerHTML = ''
