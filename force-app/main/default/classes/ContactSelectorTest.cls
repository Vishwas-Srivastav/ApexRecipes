/**
 * @description Unit tests for ContactSelector.
 * @author Vishwas Srivastav
 * @group Enterprise Architecture Patterns
 */
@IsTest
private class ContactSelectorTest {

    @IsTest
    static void testSelectById() {
        Account acc = new Account(Name = 'Selector Parent Account');
        insert acc;

        Contact con = new Contact(FirstName = 'Test', LastName = 'Selector', AccountId = acc.Id);
        insert con;

        ContactSelector selector = new ContactSelector();
        List<Contact> results = selector.selectById(new Set<Id>{ con.Id });

        Assert.areEqual(1, results.size(), 'Should select 1 Contact by ID');
        Assert.areEqual('Selector', results[0].LastName, 'LastName should match test record');
    }

    @IsTest
    static void testSelectByAccountId() {
        Account acc = new Account(Name = 'Selector Parent Account');
        insert acc;

        Contact con = new Contact(FirstName = 'Test', LastName = 'Selector', AccountId = acc.Id);
        insert con;

        ContactSelector selector = new ContactSelector();
        List<Contact> results = selector.selectByAccountId(new Set<Id>{ acc.Id });

        Assert.areEqual(1, results.size(), 'Should select 1 Contact by Account ID');
    }
}
