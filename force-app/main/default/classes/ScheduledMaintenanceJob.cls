/**
 * @description Schedulable Apex job encapsulating scheduled database maintenance routines and helper methods for programmatic scheduling.
 * @author Vishwas Srivastav
 * @group Asynchronous Apex Architecture
 */
public with sharing class ScheduledMaintenanceJob implements Schedulable {

    public static final String DEFAULT_CRON_DAILY_MIDNIGHT = '0 0 0 * * ?';

    /**
     * @description Execution handler invoked by the System scheduler.
     * @param context SchedulableContext provided by the platform.
     */
    public void execute(SchedulableContext context) {
        System.debug(LoggingLevel.INFO, 'Executing scheduled maintenance job: ' + context.getTriggerId());
        this.runMaintenance();
    }

    /**
     * @description Programmatically schedules the maintenance job.
     * @param jobName Name identifier for the scheduled job.
     * @param cronExpression Valid Cron expression defining schedule.
     * @return String Id of the created CronTrigger job record.
     */
    public static String scheduleJob(String jobName, String cronExpression) {
        String cron = String.isNotBlank(cronExpression) ? cronExpression : DEFAULT_CRON_DAILY_MIDNIGHT;
        String name = String.isNotBlank(jobName) ? jobName : 'SystemMaintenanceJob';
        return System.schedule(name, cron, new ScheduledMaintenanceJob());
    }

    @TestVisible
    private void runMaintenance() {
        System.debug(LoggingLevel.INFO, 'System maintenance routine complete.');
    }
}
