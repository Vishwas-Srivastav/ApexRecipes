/**
 * @description Custom REST Web Service API endpoint exposing Account retrieval and creation capabilities over HTTP.
 * @author Vishwas Srivastav
 * @group REST Integration Suite
 */
@RestResource(urlMapping='/v1/accounts/*')
global with sharing class RestCustomEndpoint {

    /**
     * @description GET endpoint fetching Account details by Record ID in URL path.
     * @return Account Account SObject matching URI path ID.
     */
    @HttpGet
    global static Account doGet() {
        RestRequest req = RestContext.request;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/') + 1);

        if (String.isBlank(accountId)) {
            return null;
        }

        List<Account> accounts = [
            SELECT Id, Name, Rating, AnnualRevenue 
            FROM Account 
            WHERE Id = :accountId 
            WITH USER_MODE
        ];

        return accounts.isEmpty() ? null : accounts[0];
    }

    /**
     * @description POST endpoint creating a new Account record from request parameters.
     * @param name Account Name.
     * @param rating Account Rating.
     * @return Id Created Account Record ID.
     */
    @HttpPost
    global static Id doPost(String name, String rating) {
        if (String.isBlank(name)) {
            RestContext.response.statusCode = 400;
            return null;
        }

        Account acc = new Account(Name = name, Rating = rating);
        insert as user acc;
        return acc.Id;
    }
}
