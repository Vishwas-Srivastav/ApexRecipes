/**
 * @description Unit tests for RestCustomEndpoint.
 * @author Vishwas Srivastav
 * @group REST Integration Suite
 */
@IsTest
private class RestCustomEndpointTest {

    @IsTest
    static void testDoGet() {
        Account acc = new Account(Name = 'REST Test Account', Rating = 'Hot');
        insert acc;

        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/v1/accounts/' + acc.Id;
        req.httpMethod = 'GET';

        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        Account result = RestCustomEndpoint.doGet();
        Test.stopTest();

        Assert.isNotNull(result, 'Account should be returned by GET endpoint');
        Assert.areEqual(acc.Id, result.Id, 'Returned Account ID should match input');
    }

    @IsTest
    static void testDoPost() {
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/v1/accounts/';
        req.httpMethod = 'POST';

        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        Id newAccountId = RestCustomEndpoint.doPost('New REST Account', 'Warm');
        Test.stopTest();

        Assert.isNotNull(newAccountId, 'Account ID should be created');
    }
}
