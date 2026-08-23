/**
 * @description Unit tests for PlatformEventPublisher.
 * @author Vishwas Srivastav
 * @group Real-time Messaging
 */
@IsTest
private class PlatformEventPublisherTest {

    @IsTest
    static void testPublishEmptyList() {
        List<Database.SaveResult> results = PlatformEventPublisher.publish(new List<SObject>());
        Assert.areEqual(0, results.size(), 'Publishing empty list should return empty results');
    }
}
