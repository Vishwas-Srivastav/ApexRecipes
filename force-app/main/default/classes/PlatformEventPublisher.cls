/**
 * @description Utility for publishing Platform Events with batching and Database.SaveResult error handling.
 * @author Vishwas Srivastav
 * @group Real-time Messaging
 */
public with sharing class PlatformEventPublisher {

    /**
     * @description Publishes a list of SObject platform events to the EventBus.
     * @param events List of Platform Event SObject records.
     * @return List<Database.SaveResult> Results of publishing operation.
     */
    public static List<Database.SaveResult> publish(List<SObject> events) {
        if (events == null || events.isEmpty()) {
            return new List<Database.SaveResult>();
        }

        List<Database.SaveResult> results = EventBus.publish(events);
        for (Database.SaveResult sr : results) {
            if (!sr.isSuccess()) {
                for (Database.Error err : sr.getErrors()) {
                    System.debug(LoggingLevel.ERROR, 'Platform Event publish error: ' + err.getMessage());
                }
            }
        }
        return results;
    }
}
