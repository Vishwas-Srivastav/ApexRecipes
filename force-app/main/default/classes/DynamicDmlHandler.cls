/**
 * @description Database DML handler enforcing field-level security via Security.stripInaccessible.
 * @author Vishwas Srivastav
 * @group Dynamic Apex & Schema Describe
 */
public with sharing class DynamicDmlHandler {

    /**
     * @description Inserts records after stripping inaccessible fields for current user.
     * @param records List of SObjects to insert.
     * @return List<SObject> Stripped records submitted to database insert.
     */
    public static List<SObject> secureInsert(List<SObject> records) {
        if (records == null || records.isEmpty()) {
            return new List<SObject>();
        }

        SObjectAccessDecision decision = Security.stripInaccessible(AccessType.CREATABLE, records);
        List<SObject> sanitizedRecords = decision.getRecords();
        Database.insert(sanitizedRecords, AccessLevel.USER_MODE);
        return sanitizedRecords;
    }

    /**
     * @description Updates records after stripping inaccessible fields.
     * @param records List of SObjects to update.
     * @return List<SObject> Stripped records submitted to database update.
     */
    public static List<SObject> secureUpdate(List<SObject> records) {
        if (records == null || records.isEmpty()) {
            return new List<SObject>();
        }

        SObjectAccessDecision decision = Security.stripInaccessible(AccessType.UPDATABLE, records);
        List<SObject> sanitizedRecords = decision.getRecords();
        Database.update(sanitizedRecords, AccessLevel.USER_MODE);
        return sanitizedRecords;
    }
}
