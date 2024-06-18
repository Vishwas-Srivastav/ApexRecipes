/**
 * @description Enterprise HTTP REST callout client with JSON serialization, header management, and response contract handling.
 * @author Vishwas Srivastav
 * @group REST Integration Suite
 */
public with sharing class RestCalloutClient {

    /**
     * @description Executes HTTP request to specified endpoint with custom method, headers, and body.
     * @param endpoint Target URL string.
     * @param method HTTP method (GET, POST, PUT, DELETE).
     * @param headers Map of HTTP request header keys and values.
     * @param body Payload string body.
     * @return HttpResponse Resulting HTTP response object.
     */
    public static HttpResponse sendRequest(String endpoint, String method, Map<String, String> headers, String body) {
        if (String.isBlank(endpoint) || String.isBlank(method)) {
            throw new IllegalArgumentException('Endpoint and HTTP method must be specified.');
        }

        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod(method.toUpperCase());
        req.setTimeout(60000);

        if (headers != null) {
            for (String key : headers.keySet()) {
                req.setHeader(key, headers.get(key));
            }
        }

        if (String.isNotBlank(body) && (method.equalsIgnoreCase('POST') || method.equalsIgnoreCase('PUT'))) {
            req.setBody(body);
        }

        Http http = new Http();
        return http.send(req);
    }
}
