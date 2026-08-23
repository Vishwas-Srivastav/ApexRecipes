/**
 * @description Domain layer pattern encapsulating object validation rules and default data population for Account collections.
 * @author Vishwas Srivastav
 * @group Enterprise Architecture Patterns
 */
public with sharing class AccountDomainHandler {

    private List<Account> records;

    /**
     * @description Constructor accepting collection of Account records.
     * @param records List of Account SObjects to manage.
     */
    public AccountDomainHandler(List<Account> records) {
        this.records = (records != null) ? records : new List<Account>();
    }

    /**
     * @description Validates account fields before insert/update.
     */
    public void validate() {
        for (Account acc : this.records) {
            if (String.isBlank(acc.Name)) {
                acc.addError('Account Name is mandatory.');
            }
        }
    }

    /**
     * @description Populates default values for new Account records.
     */
    public void populateDefaults() {
        for (Account acc : this.records) {
            if (String.isBlank(acc.Rating)) {
                acc.Rating = 'Warm';
            }
        }
    }
}
