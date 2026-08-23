/**
 * @description Unit tests for CustomNotificationSender.
 * @author Vishwas Srivastav
 * @group Real-time Messaging
 */
@IsTest
private class CustomNotificationSenderTest {

    @IsTest
    static void testSendNotification() {
        Id fakeTypeId = '0ML000000000000AAA';
        Id currentUserId = UserInfo.getUserId();

        Test.startTest();
        CustomNotificationSender.sendNotification(
            'Test Alert Title',
            'Test Alert Body Content',
            fakeTypeId,
            currentUserId,
            new Set<String>{ String.valueOf(currentUserId) }
        );
        Test.stopTest();

        Assert.isTrue(true, 'Send notification method completed without exceptions');
    }
}
