/**
 * @description Unit tests for DynamicDmlHandler.
 * @author Vishwas Srivastav
 * @group Dynamic Apex & Schema Describe
 */
@IsTest
private class DynamicDmlHandlerTest {

    @IsTest
    static void testSecureInsertAndUpdate() {
        Account acc = new Account(Name = 'Dynamic DML Test');
        List<SObject> insertedRecords = DynamicDmlHandler.secureInsert(new List<SObject>{ acc });

        Assert.areEqual(1, insertedRecords.size(), 'Should insert 1 record');
        Assert.isNotNull(insertedRecords[0].Id, 'Inserted record ID should be populated');

        acc.Name = 'Updated Dynamic DML Name';
        List<SObject> updatedRecords = DynamicDmlHandler.secureUpdate(new List<SObject>{ acc });
        Assert.areEqual(1, updatedRecords.size(), 'Should update 1 record');
    }
}
