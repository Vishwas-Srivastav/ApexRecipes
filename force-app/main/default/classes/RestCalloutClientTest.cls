/**
 * @description Unit tests for RestCalloutClient.
 * @author Vishwas Srivastav
 * @group REST Integration Suite
 */
@IsTest
private class RestCalloutClientTest {

    @IsTest
    static void testSendRequestSuccess() {
        Test.setMock(HttpCalloutMock.class, new RestCalloutMockFactory(200, 'OK', '{"status":"success"}', new Map<String, String>{'Content-Type' => 'application/json'}));

        Test.startTest();
        HttpResponse res = RestCalloutClient.sendRequest(
            'https://api.example.com/v1/data',
            'POST',
            new Map<String, String>{ 'Content-Type' => 'application/json' },
            '{"name":"Test"}'
        );
        Test.stopTest();

        Assert.areEqual(200, res.getStatusCode(), 'Status code should be 200');
        Assert.areEqual('{"status":"success"}', res.getBody(), 'Body should match mock payload');
    }
}
