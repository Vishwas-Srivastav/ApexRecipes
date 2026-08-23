/**
 * @description Unit tests for BatchDatabaseLocator.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
@IsTest
private class BatchDatabaseLocatorTest {

    @IsTest
    static void testBatchExecution() {
        Account acc = new Account(Name = 'Batch Locator Test Account', AnnualRevenue = 500000);
        insert acc;

        Test.startTest();
        BatchDatabaseLocator batch = new BatchDatabaseLocator();
        Database.executeBatch(batch);
        Test.stopTest();

        Account updatedAcc = [SELECT Id, Description FROM Account WHERE Id = :acc.Id];
        Assert.isNotNull(updatedAcc.Description, 'Account description should be updated by batch job');
    }
}
