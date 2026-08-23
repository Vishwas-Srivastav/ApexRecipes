/**
 * @description Controller implementation for Apex Continuation pattern managing asynchronous non-blocking HTTP callouts.
 * @author Vishwas Srivastav
 * @group REST Integration Suite
 */
public with sharing class ContinuationCalloutController {

    @TestVisible
    private static String requestLabel;

    /**
     * @description Initializes Apex Continuation request targeting external web service.
     * @return Object System Continuation object instance.
     */
    @AuraEnabled(continuation=true cacheable=true)
    public static Object startRequest() {
        Continuation con = new Continuation(60);
        con.continuationMethod = 'processResponse';

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.example.com/v1/continuation');
        req.setMethod('GET');

        requestLabel = con.addHttpRequest(req);
        return con;
    }

    /**
     * @description Callback handler processing response from Continuation callout.
     * @param labels List of labels associated with callout requests.
     * @param state State parameter object.
     * @return String Response body or error result.
     */
    @AuraEnabled
    public static Object processResponse(List<String> labels, Object state) {
        HttpResponse response = Continuation.getResponse(labels[0]);
        return response.getBody();
    }
}
