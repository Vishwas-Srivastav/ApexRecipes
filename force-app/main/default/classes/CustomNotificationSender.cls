/**
 * @description Builder pattern for constructing and dispatching Messaging.CustomNotification alerts to desktop and mobile targets.
 * @author Vishwas Srivastav
 * @group Real-time Messaging
 */
public with sharing class CustomNotificationSender {

    /**
     * @description Dispatches custom notification alert to target recipient user IDs.
     * @param title Alert title string.
     * @param body Alert notification body text.
     * @param notificationTypeId CustomNotificationType ID.
     * @param targetId Target SObject Record ID.
     * @param recipientIds Set of recipient User IDs.
     */
    public static void sendNotification(String title, String body, Id notificationTypeId, String targetId, Set<String> recipientIds) {
        if (String.isBlank(title) || String.isBlank(body) || notificationTypeId == null || recipientIds == null || recipientIds.isEmpty()) {
            return;
        }

        Messaging.CustomNotification notification = new Messaging.CustomNotification();
        notification.setTitle(title);
        notification.setBody(body);
        notification.setNotificationTypeId(notificationTypeId);
        notification.setTargetId(targetId);

        if (!Test.isRunningTest()) {
            notification.send(recipientIds);
        }
    }
}
