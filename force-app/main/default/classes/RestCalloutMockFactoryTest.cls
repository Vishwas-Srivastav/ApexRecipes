/**
 * @description Unit tests for RestCalloutMockFactory.
 * @author Vishwas Srivastav
 * @group REST Integration Suite
 */
@IsTest
private class RestCalloutMockFactoryTest {

    @IsTest
    static void testMockFactoryRespond() {
        RestCalloutMockFactory mock = new RestCalloutMockFactory(
            201, 
            'Created', 
            '{"id":"123"}', 
            new Map<String, String>{ 'Location' => '/v1/accounts/123' }
        );

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.example.com/v1/accounts');
        req.setMethod('POST');

        HttpResponse res = mock.respond(req);

        Assert.areEqual(201, res.getStatusCode(), 'Status code should match input 201');
        Assert.areEqual('Created', res.getStatus(), 'Status string should match');
        Assert.areEqual('{"id":"123"}', res.getBody(), 'Body payload should match');
        Assert.areEqual('/v1/accounts/123', res.getHeader('Location'), 'Header should match');
    }
}
