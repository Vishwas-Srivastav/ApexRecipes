/**
 * @description Stateful batch Apex processor accumulating execution metrics across chunk iterations.
 * @author Vishwas Srivastav
 * @group Asynchronous Apex Architecture
 */
public with sharing class BatchStatefulProcessor implements Database.Batchable<SObject>, Database.Stateful {

    @TestVisible
    private Integer recordsProcessed = 0;

    @TestVisible
    private Integer successCount = 0;

    @TestVisible
    private Integer failureCount = 0;

    /**
     * @description Collects records to pass into the batch execution pipeline.
     * @param context BatchableContext passed by system runtime.
     * @return Database.QueryLocator Query locator defining record scope.
     */
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('SELECT Id, Name FROM Account WHERE CreatedDate = TODAY');
    }

    /**
     * @description Executes business logic on a scoped chunk of SObject records.
     * @param context BatchableContext passed by system runtime.
     * @param scope List of SObjects in current chunk iteration.
     */
    public void execute(Database.BatchableContext context, List<Account> scope) {
        this.recordsProcessed += scope.size();
        for (Account acc : scope) {
            if (String.isNotBlank(acc.Name)) {
                this.successCount++;
            } else {
                this.failureCount++;
            }
        }
    }

    /**
     * @description Post-processing operations executed after all chunks complete.
     * @param context BatchableContext passed by system runtime.
     */
    public void finish(Database.BatchableContext context) {
        System.debug(LoggingLevel.INFO, 'Batch execution complete. Total processed: ' + this.recordsProcessed + 
                     ', Successes: ' + this.successCount + ', Failures: ' + this.failureCount);
    }
}
