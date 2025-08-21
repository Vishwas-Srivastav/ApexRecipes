/**
 * @author            : Vishwas Srivastav
 * @group             : 
 * @last modified on  : 08-21-2025
 * @last modified by  : Vishwas Srivastav
 * 
 * SOQL Recipes
 * -----------------------------------------
 * This class demonstrates common SOQL queries.
 * 
 * Best Practices:
 * 1. Always use "with sharing" unless system-level access is required.
 * 2. Use LIMIT when you don’t need the full dataset.
 * 3. Use selective WHERE clauses to avoid SOQL 101 errors.
 * 4. Keep queries bulk-safe and never inside tight loops.
 * 5. Remember User Mode vs. System Mode:
 *    - User Mode (default for SOQL in Apex): Respects sharing rules & FLS.
 *    - System Mode: Apex runs without sharing unless "with sharing" is specified.
 */

 public with sharing class SOQLRecipes {
    
    public static void run() {
        
        // 1. Basic Query - Fetch first 5 Accounts
        List<Account> accounts = [
            SELECT Id, Name 
            FROM Account 
            LIMIT 5
        ];
        
        // 2. WHERE Clause - Fetch Contacts by Email domain
        List<Contact> contacts = [
            SELECT Id, Name, Email 
            FROM Contact 
            WHERE Email LIKE :('%@example.com') 
            LIMIT 10
        ];
        
        // 3. Relationship Query (Parent-to-Child) - Accounts with Contacts
        List<Account> accWithContacts = [
            SELECT Id, Name, 
                (SELECT Id, Name, Email FROM Contacts LIMIT 3) 
            FROM Account 
            LIMIT 5
        ];
        
        // 4. Relationship Query (Child-to-Parent) - Contacts with Account info
        List<Contact> contactsWithAccount = [
            SELECT Id, Name, Account.Name, Account.Industry 
            FROM Contact 
            WHERE AccountId != null 
            LIMIT 10
        ];
        
        // 5. Aggregate Query - Count Accounts by Industry
        List<AggregateResult> accountsByIndustry = [
            SELECT Industry, COUNT(Id) total 
            FROM Account 
            GROUP BY Industry
        ];
        
        // 6. Aggregate Query - Sum of Opportunities grouped by Stage
        List<AggregateResult> oppByStage = [
            SELECT StageName, SUM(Amount) totalAmount 
            FROM Opportunity 
            GROUP BY StageName
        ];
        
        // 7. ORDER BY - Contacts sorted by LastName
        List<Contact> orderedContacts = [
            SELECT Id, Name, Email 
            FROM Contact 
            ORDER BY LastName ASC NULLS LAST 
            LIMIT 10
        ];
        
        // 8. Date Literals - Opportunities created in last 30 days
        List<Opportunity> recentOpps = [
            SELECT Id, Name, Amount, CloseDate 
            FROM Opportunity 
            WHERE CreatedDate = LAST_N_DAYS:30
            LIMIT 10
        ];
        
        // 9. IN Clause - Accounts filtered by Ids
        Set<Id> accountIds = new Set<Id>{'001xx000003DGSxAAO', '001xx000003DGSyAAO'};
        List<Account> specificAccounts = [
            SELECT Id, Name 
            FROM Account 
            WHERE Id IN :accountIds
        ];
        
        // 10. Semi-Join - Accounts that have Contacts
        List<Account> accountsWithContacts = [
            SELECT Id, Name 
            FROM Account 
            WHERE Id IN (SELECT AccountId FROM Contact)
            LIMIT 10
        ];
        
        // 11. Anti-Join - Accounts with no Contacts
        List<Account> accountsWithoutContacts = [
            SELECT Id, Name 
            FROM Account 
            WHERE Id NOT IN (SELECT AccountId FROM Contact)
            LIMIT 10
        ];
        
        // 12. OFFSET - Pagination example (skip first 5, fetch next 5)
        List<Contact> pagedContacts = [
            SELECT Id, Name, Email 
            FROM Contact 
            ORDER BY Name 
            LIMIT 5 OFFSET 5
        ];
        
        // 13. FOR VIEW - Query for reporting purposes
        List<Account> viewedAccounts = [
            SELECT Id, Name 
            FROM Account 
            LIMIT 5 
            FOR VIEW
        ];
        
        // 14. FOR REFERENCE - Query for auditing/reference purposes
        List<Account> referencedAccounts = [
            SELECT Id, Name 
            FROM Account 
            LIMIT 5 
            FOR REFERENCE
        ];
    }
}
