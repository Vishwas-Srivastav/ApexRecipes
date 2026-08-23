/**
 * @description Database.QueryLocator batch processing recipe handling high-volume record processing.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
public with sharing class BatchDatabaseLocator implements Database.Batchable<SObject> {

    /**
     * @description Constructs query locator defining high-volume record scope.
     * @param context BatchableContext passed by system runtime.
     * @return Database.QueryLocator Query locator instance.
     */
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('SELECT Id, Name, AnnualRevenue FROM Account WHERE AnnualRevenue != NULL');
    }

    /**
     * @description Executes processing logic on scoped chunk of SObjects.
     * @param context BatchableContext passed by system runtime.
     * @param scope Scoped SObject list.
     */
    public void execute(Database.BatchableContext context, List<Account> scope) {
        for (Account acc : scope) {
            acc.Description = 'Processed by BatchDatabaseLocator on ' + String.valueOf(Date.today());
        }
        Database.update(scope, AccessLevel.USER_MODE);
    }

    /**
     * @description Finish method executed after all batch chunks complete.
     * @param context BatchableContext passed by system runtime.
     */
    public void finish(Database.BatchableContext context) {
        System.debug(LoggingLevel.INFO, 'BatchDatabaseLocator execution complete.');
    }
}
