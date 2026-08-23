/**
 * @description Unit tests for UnitOfWorkManager.
 * @author Vishwas Srivastav
 * @group Enterprise Architecture Patterns
 */
@IsTest
private class UnitOfWorkManagerTest {

    @IsTest
    static void testUnitOfWorkLifecycle() {
        UnitOfWorkManager uow = new UnitOfWorkManager();

        Account acc = new Account(Name = 'UOW Test Account');
        uow.registerNew(acc);
        uow.commitWork();

        Assert.isNotNull(acc.Id, 'Account ID should be populated after insert commit');

        acc.Name = 'UOW Updated Account';
        uow.registerDirty(acc);
        uow.commitWork();

        Account reloadedAcc = [SELECT Id, Name FROM Account WHERE Id = :acc.Id];
        Assert.areEqual('UOW Updated Account', reloadedAcc.Name, 'Account name should be updated');

        uow.registerDeleted(acc);
        uow.commitWork();

        List<Account> checkDeleted = [SELECT Id FROM Account WHERE Id = :acc.Id];
        Assert.areEqual(0, checkDeleted.size(), 'Account should be deleted');
    }
}
