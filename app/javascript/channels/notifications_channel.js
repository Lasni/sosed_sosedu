import consumer from "./consumer";

consumer.subscriptions.create("NotificationsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected from notifications_channel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("data", data);
    const notificationsFrame = document.getElementById("notifications");
    notificationsFrame.insertAdjacentHTML("afterbegin", data.turbo_stream);

    // Update notification count
    const notificationCountElement =
      document.getElementById("notification-count");
    if (notificationCountElement) {
      notificationCountElement.innerHTML = `${data.unread_count} <i class="bi bi-bell-fill"></i>`;
    }
  },
});
