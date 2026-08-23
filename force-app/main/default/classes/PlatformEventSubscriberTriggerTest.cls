/**
 * @description Unit tests for PlatformEventSubscriberTrigger.
 * @author Vishwas Srivastav
 * @group Real-time Messaging
 */
@IsTest
private class PlatformEventSubscriberTriggerTest {

    @IsTest
    static void testProcessEvents() {
        PlatformEventSubscriberTrigger.processEvents(new List<SObject>{ new Task(Subject = 'Event Task') });
        Assert.areEqual(1, PlatformEventSubscriberTrigger.processedCount, 'Should increment processed event count to 1');
    }
}
