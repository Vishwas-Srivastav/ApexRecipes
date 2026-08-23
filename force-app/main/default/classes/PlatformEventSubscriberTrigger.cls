/**
 * @description Processor class invoked by triggers subscribing to incoming Platform Event payloads.
 * @author Vishwas Srivastav
 * @group Real-time Messaging
 */
public with sharing class PlatformEventSubscriberTrigger {

    @TestVisible
    private static Integer processedCount = 0;

    /**
     * @description Handler logic processing event payloads.
     * @param events List of event SObject records.
     */
    public static void processEvents(List<SObject> events) {
        if (events == null || events.isEmpty()) {
            return;
        }
        processedCount += events.size();
        System.debug(LoggingLevel.INFO, 'Processed ' + events.size() + ' platform event records.');
    }
}
