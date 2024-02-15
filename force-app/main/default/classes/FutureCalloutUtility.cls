/**
 * @description Future callout utility providing async HTTP execution with error logging wrappers.
 * @author Vishwas Srivastav
 * @group Asynchronous Apex Architecture
 */
public with sharing class FutureCalloutUtility {

    @TestVisible
    private static Integer mockStatusCode = 200;

    /**
     * @description Future method performing asynchronous HTTP GET request.
     * @param endpoint Target URL endpoint.
     */
    @future(callout=true)
    public static void executeAsyncCallout(String endpoint) {
        if (String.isBlank(endpoint)) {
            return;
        }

        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setMethod('GET');
            req.setTimeout(120000);

            Http http = new Http();
            HttpResponse res = Test.isRunningTest() ? getMockResponse() : http.send(req);

            if (res.getStatusCode() >= 400) {
                System.debug(LoggingLevel.ERROR, 'HTTP Callout failed with status code: ' + res.getStatusCode());
            }
        } catch (Exception ex) {
            System.debug(LoggingLevel.ERROR, 'Exception during future callout: ' + ex.getMessage());
        }
    }

    private static HttpResponse getMockResponse() {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(mockStatusCode);
        res.setBody('{"status":"ok"}');
        return res;
    }
}
