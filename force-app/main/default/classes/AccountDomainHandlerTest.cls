/**
 * @description Unit tests for AccountDomainHandler.
 * @author Vishwas Srivastav
 * @group Enterprise Architecture Patterns
 */
@IsTest
private class AccountDomainHandlerTest {

    @IsTest
    static void testPopulateDefaults() {
        List<Account> accounts = new List<Account>{ new Account(Name = 'Domain Test Account') };
        AccountDomainHandler domain = new AccountDomainHandler(accounts);

        domain.populateDefaults();

        Assert.areEqual('Warm', accounts[0].Rating, 'Rating should default to Warm');
    }

    @IsTest
    static void testValidation() {
        List<Account> accounts = new List<Account>{ new Account(Name = 'Valid Account') };
        AccountDomainHandler domain = new AccountDomainHandler(accounts);

        try {
            domain.validate();
            Assert.isTrue(true, 'Validation should pass for valid account');
        } catch (Exception ex) {
            Assert.fail('Validation threw unexpected exception: ' + ex.getMessage());
        }
    }
}
