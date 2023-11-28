# frozen_string_literal: true

class PushNotificationService
  def self.send_notification(title, body, push_subscription)
    WebPush.payload_send(
      message: {
        title:,
        body:
      }.to_json,
      endpoint: push_subscription.endpoint,
      p256dh: push_subscription.p256dh,
      auth: push_subscription.auth,
      vapid: {
        subject: 'mailto:sender@example.com',
        public_key: Rails.application.credentials.dig(:vapid, :public_key),
        private_key: Rails.application.credentials.dig(:vapid, :private_key)
      },
      ssl_timeout: 5,
      open_timeout: 5,
      read_timeout: 5
    )
  end
end
