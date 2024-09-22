/**
 * @description Unit tests for DynamicQueryBuilder.
 * @author Vishwas Srivastav
 * @group Dynamic Apex & Schema Describe
 */
@IsTest
private class DynamicQueryBuilderTest {

    @IsTest
    static void testExecuteWithBinds() {
        Account acc = new Account(Name = 'Query Builder Test Account');
        insert acc;

        DynamicQueryBuilder builder = new DynamicQueryBuilder('Account');
        builder.selectFields(new Set<String>{ 'Id', 'Name' });
        builder.setWhere('Name = :accName');

        Map<String, Object> binds = new Map<String, Object>{ 'accName' => 'Query Builder Test Account' };

        Test.startTest();
        List<SObject> results = builder.executeWithBinds(binds);
        Test.stopTest();

        Assert.areEqual(1, results.size(), 'Should find 1 Account matching bind variable');
        Assert.areEqual(acc.Id, results[0].Id, 'Returned record ID should match');
    }
}
