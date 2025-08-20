/**
 * @description       : A boilerplate for scheduled jobs using the Schedulable interface. Best for automating recurring processes like nightly jobs or periodic maintenance.
 * @author            : Vishwas Srivastav
 * @group             : 
 * @last modified on  : 08-21-2025
 * @last modified by  : Vishwas Srivastav
**/
global class SchedulerBoilerplate implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        System.debug('SchedulerBoilerplate executed at ' + System.now());
        // Example: Database.executeBatch(new BatchBoilerplate());
    }
}

// ➡ Schedule in Apex:
//String cron = '0 0 12 * * ?'; // Every day at 12 PM
//System.schedule('SchedulerBoilerplate Job', cron, new SchedulerBoilerplate());
