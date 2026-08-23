/**
 * @description Unit tests for BatchStatefulProcessor.
 * @author Vishwas Srivastav
 * @group Asynchronous Apex Architecture
 */
@IsTest
private class BatchStatefulProcessorTest {

    @IsTest
    static void testBatchExecution() {
        Account testAcc = new Account(Name = 'Stateful Test Account');
        insert testAcc;

        Test.startTest();
        BatchStatefulProcessor batch = new BatchStatefulProcessor();
        Database.executeBatch(batch);
        Test.stopTest();

        Assert.areEqual(1, batch.recordsProcessed, 'Should process 1 record created today');
        Assert.areEqual(1, batch.successCount, 'Should have 1 successful record processing');
    }
}
