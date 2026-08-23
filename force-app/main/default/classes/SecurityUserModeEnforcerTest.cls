/**
 * @description Unit tests for SecurityUserModeEnforcer.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
@IsTest
private class SecurityUserModeEnforcerTest {

    @IsTest
    static void testUserModeOperations() {
        Account acc = new Account(Name = 'User Mode Enforcer Test');
        List<Database.SaveResult> results = SecurityUserModeEnforcer.insertUserMode(new List<SObject>{ acc });
        Assert.areEqual(1, results.size(), 'Should return 1 save result');
        Assert.isTrue(results[0].isSuccess(), 'Insert should succeed');

        List<SObject> queried = SecurityUserModeEnforcer.queryUserMode('SELECT Id, Name FROM Account WHERE Id = \'' + acc.Id + '\'');
        Assert.areEqual(1, queried.size(), 'Should return 1 queried record in user mode');
    }
}
