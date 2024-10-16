import { createConsumer } from "@rails/actioncable"

const consumer = createConsumer()

document.addEventListener("turbo:load", () => {
  const messagesContainer = document.getElementById("messages-container");

  if (messagesContainer) {
    const chatroomId = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", chatroom_id: chatroomId }, {
      received(data) {
        // Append the new message to the messages container
        messagesContainer.insertAdjacentHTML('beforeend', data.message)
        // Scroll to the bottom of the messages container
        messagesContainer.scrollTop = messagesContainer.scrollHeight;
      }
    });
  }
});
