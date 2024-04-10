/**
 * @description Unit of Work manager pattern orchestrating atomic transactional DML operations across multiple SObject types.
 * @author Vishwas Srivastav
 * @group Enterprise Architecture Patterns
 */
public with sharing class UnitOfWorkManager {

    @TestVisible
    private List<SObject> inserts = new List<SObject>();

    @TestVisible
    private List<SObject> updates = new List<SObject>();

    @TestVisible
    private List<SObject> deletes = new List<SObject>();

    /**
     * @description Registers an SObject record for database insertion.
     * @param record SObject record to insert.
     */
    public void registerNew(SObject record) {
        if (record != null) {
            this.inserts.add(record);
        }
    }

    /**
     * @description Registers an SObject record for database update.
     * @param record SObject record to update.
     */
    public void registerDirty(SObject record) {
        if (record != null && record.Id != null) {
            this.updates.add(record);
        }
    }

    /**
     * @description Registers an SObject record for deletion.
     * @param record SObject record to delete.
     */
    public void registerDeleted(SObject record) {
        if (record != null && record.Id != null) {
            this.deletes.add(record);
        }
    }

    /**
     * @description Commits all registered DML operations in an atomic transaction.
     */
    public void commitWork() {
        if (!this.inserts.isEmpty()) {
            Database.insert(this.inserts, AccessLevel.USER_MODE);
            this.inserts.clear();
        }
        if (!this.updates.isEmpty()) {
            Database.update(this.updates, AccessLevel.USER_MODE);
            this.updates.clear();
        }
        if (!this.deletes.isEmpty()) {
            Database.delete(this.deletes, AccessLevel.USER_MODE);
            this.deletes.clear();
        }
    }
}
