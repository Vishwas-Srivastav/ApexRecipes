/**
 * @description       : A template for Batch Apex with start, execute, and finish methods. Ideal for processing large data volumes asynchronously, such as mass updates or data cleanup.
 * @author            : Vishwas Srivastav
 * @group             : 
 * @last modified on  : 08-21-2025
 * @last modified by  : Vishwas Srivastav
**/
global class BatchBoilerplate implements Database.Batchable<sObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM Account');
    }

    global void execute(Database.BatchableContext bc, List<sObject> scope) {
        // Processing logic
        update scope;
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('BatchBoilerplate completed successfully');
    }
}

//➡ Run with: Database.executeBatch(new BatchBoilerplate(), 200);
