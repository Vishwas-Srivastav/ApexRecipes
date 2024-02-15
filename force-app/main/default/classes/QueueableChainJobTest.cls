/**
 * @description Unit tests for QueueableChainJob.
 * @author Vishwas Srivastav
 * @group Asynchronous Apex Architecture
 */
@IsTest
private class QueueableChainJobTest {

    @IsTest
    static void testQueueableExecution() {
        List<Id> mockIds = new List<Id>{ '001000000000001AAA' };
        QueueableChainJob job = new QueueableChainJob(mockIds, 1);

        Test.startTest();
        System.enqueueJob(job);
        Test.stopTest();

        Assert.areEqual(1, job.depth, 'Job depth should equal initialized value');
        Assert.areEqual(1, job.recordIds.size(), 'Job record count should equal input list size');
    }
}
