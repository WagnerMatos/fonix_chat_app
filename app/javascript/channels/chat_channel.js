import consumer from "./consumer"

consumer.subscriptions.create("ChatChannel", {
  received(data) {
    const messages = document.getElementById("messages")
    messages.insertAdjacentHTML("beforeend", data.message)
  }
});
