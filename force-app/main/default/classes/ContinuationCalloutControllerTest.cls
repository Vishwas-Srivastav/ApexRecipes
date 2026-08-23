/**
 * @description Unit tests for ContinuationCalloutController.
 * @author Vishwas Srivastav
 * @group REST Integration Suite
 */
@IsTest
private class ContinuationCalloutControllerTest {

    @IsTest
    static void testStartRequestAndProcessResponse() {
        Continuation con = (Continuation) ContinuationCalloutController.startRequest();
        Assert.isNotNull(con, 'Continuation object should be instantiated');

        HttpResponse mockRes = new HttpResponse();
        mockRes.setStatusCode(200);
        mockRes.setBody('{"result":"success"}');

        Test.setContinuationResponse(ContinuationCalloutController.requestLabel, mockRes);

        Object response = ContinuationCalloutController.processResponse(new List<String>{ ContinuationCalloutController.requestLabel }, null);
        Assert.areEqual('{"result":"success"}', (String) response, 'Response body should match continuation result');
    }
}
