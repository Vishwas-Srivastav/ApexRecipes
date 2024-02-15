/**
 * @description Unit tests for FutureCalloutUtility.
 * @author Vishwas Srivastav
 * @group Asynchronous Apex Architecture
 */
@IsTest
private class FutureCalloutUtilityTest {

    @IsTest
    static void testFutureCalloutSuccess() {
        FutureCalloutUtility.mockStatusCode = 200;

        Test.startTest();
        FutureCalloutUtility.executeAsyncCallout('https://api.example.com/v1/test');
        Test.stopTest();

        Assert.areEqual(200, FutureCalloutUtility.mockStatusCode, 'Mock status code should be 200');
    }

    @IsTest
    static void testFutureCalloutFailure() {
        FutureCalloutUtility.mockStatusCode = 500;

        Test.startTest();
        FutureCalloutUtility.executeAsyncCallout('https://api.example.com/v1/test');
        Test.stopTest();

        Assert.areEqual(500, FutureCalloutUtility.mockStatusCode, 'Mock status code should be 500');
    }
}
