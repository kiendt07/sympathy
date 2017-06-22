App.notifications = App.cable.subscriptions.create('NotificationsChannel', {
  received: function(data) {
    $('.notifications-wrapper').prepend(data.html);
  }
});
