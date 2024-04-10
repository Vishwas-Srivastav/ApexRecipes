/**
 * @description Selector layer pattern encapsulating query construction, field set selection, and secure database retrieval for Contact records.
 * @author Vishwas Srivastav
 * @group Enterprise Architecture Patterns
 */
public with sharing class ContactSelector {

    /**
     * @description Selects contacts by ID list with USER_MODE security enforcement.
     * @param contactIds Set of Contact Record IDs.
     * @return List<Contact> Retrieved Contact records.
     */
    public List<Contact> selectById(Set<Id> contactIds) {
        if (contactIds == null || contactIds.isEmpty()) {
            return new List<Contact>();
        }
        return [
            SELECT Id, FirstName, LastName, Email, AccountId, Phone 
            FROM Contact 
            WHERE Id IN :contactIds 
            WITH USER_MODE
        ];
    }

    /**
     * @description Selects contacts associated with parent Account IDs.
     * @param accountIds Set of Account Record IDs.
     * @return List<Contact> Contacts belonging to specified Accounts.
     */
    public List<Contact> selectByAccountId(Set<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) {
            return new List<Contact>();
        }
        return [
            SELECT Id, FirstName, LastName, Email, AccountId 
            FROM Contact 
            WHERE AccountId IN :accountIds 
            WITH USER_MODE
        ];
    }
}
