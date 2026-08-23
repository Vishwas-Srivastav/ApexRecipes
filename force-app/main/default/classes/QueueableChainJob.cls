/**
 * @description Queueable Apex implementation supporting chaining, retry limits, and async payload processing.
 * @author Vishwas Srivastav
 * @group Asynchronous Apex Architecture
 */
public with sharing class QueueableChainJob implements Queueable, Finalizer {

    @TestVisible
    private List<Id> recordIds;

    @TestVisible
    private Integer depth;

    private static final Integer MAX_CHAIN_DEPTH = 3;

    /**
     * @description Parameterized constructor accepting record IDs and current execution depth.
     * @param recordIds List of SObject Record IDs to process.
     * @param depth Current recursion/chain depth level.
     */
    public QueueableChainJob(List<Id> recordIds, Integer depth) {
        this.recordIds = (recordIds != null) ? recordIds : new List<Id>();
        this.depth = (depth != null) ? depth : 1;
    }

    /**
     * @description Executes the Queueable job logic and chains a secondary job if criteria are met.
     * @param context QueueableContext passed by System runtime.
     */
    public void execute(QueueableContext context) {
        // Attach Finalizer to capture transaction result
        System.attachFinalizer(this);

        this.processRecords();

        if (this.depth < MAX_CHAIN_DEPTH && !this.recordIds.isEmpty() && !Test.isRunningTest()) {
            System.enqueueJob(new QueueableChainJob(this.recordIds, this.depth + 1));
        }
    }

    /**
     * @description Finalizer interface execution handler logging transaction status.
     * @param context FinalizerContext provided by system.
     */
    public void execute(FinalizerContext context) {
        if (context.getResult() == ParentJobResult.SUCCESS) {
            System.debug(LoggingLevel.INFO, 'QueueableChainJob succeeded for Parent Job ID: ' + context.getAsyncApexJobId());
        } else {
            System.debug(LoggingLevel.ERROR, 'QueueableChainJob failed with exception: ' + context.getException());
        }
    }

    @TestVisible
    private void processRecords() {
        System.debug(LoggingLevel.INFO, 'Processing ' + this.recordIds.size() + ' records at depth ' + this.depth);
    }
}
