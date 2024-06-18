/**
 * @description Reusable HttpCalloutMock factory implementation supporting dynamic response codes, headers, and body payloads for test suites.
 * @author Vishwas Srivastav
 * @group REST Integration Suite
 */
public with sharing class RestCalloutMockFactory implements HttpCalloutMock {

    protected Integer code;
    protected String status;
    protected String bodyAsString;
    protected Map<String, String> responseHeaders;

    /**
     * @description Parameterized constructor initializing mock HTTP parameters.
     * @param code HTTP status code.
     * @param status HTTP status string.
     * @param body Response body string.
     * @param responseHeaders Map of response headers.
     */
    public RestCalloutMockFactory(Integer code, String status, String body, Map<String, String> responseHeaders) {
        this.code = code;
        this.status = status;
        this.bodyAsString = body;
        this.responseHeaders = responseHeaders;
    }

    /**
     * @description Implementation of HttpCalloutMock respond interface method.
     * @param req HttpRequest object.
     * @return HttpResponse Constructed mock HttpResponse.
     */
    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(this.code);
        res.setStatus(this.status);
        res.setBody(this.bodyAsString);
        if (this.responseHeaders != null) {
            for (String key : this.responseHeaders.keySet()) {
                res.setHeader(key, this.responseHeaders.get(key));
            }
        }
        return res;
    }
}
