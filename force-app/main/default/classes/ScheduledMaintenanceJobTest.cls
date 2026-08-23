/**
 * @description Unit tests for ScheduledMaintenanceJob.
 * @author Vishwas Srivastav
 * @group Asynchronous Apex Architecture
 */
@IsTest
private class ScheduledMaintenanceJobTest {

    @IsTest
    static void testScheduledExecution() {
        Test.startTest();
        String cron = ScheduledMaintenanceJob.DEFAULT_CRON_DAILY_MIDNIGHT;
        String jobId = ScheduledMaintenanceJob.scheduleJob('Test Maintenance Job', cron);
        Test.stopTest();

        Assert.isNotNull(jobId, 'Job ID returned by System.schedule should not be null');
    }
}
