/**
 * @description Apex user-mode SOQL and DML security enforcement utility.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
public with sharing class SecurityUserModeEnforcer {

    /**
     * @description Executes SOQL query with USER_MODE security enforcement.
     * @param query SOQL query string.
     * @return List<SObject> Query results.
     */
    public static List<SObject> queryUserMode(String query) {
        if (String.isBlank(query)) {
            return new List<SObject>();
        }
        return Database.query(query, AccessLevel.USER_MODE);
    }

    /**
     * @description Performs DML insert with USER_MODE security enforcement.
     * @param records Records to insert.
     * @return List<Database.SaveResult> Save results.
     */
    public static List<Database.SaveResult> insertUserMode(List<SObject> records) {
        if (records == null || records.isEmpty()) {
            return new List<Database.SaveResult>();
        }
        return Database.insert(records, false, AccessLevel.USER_MODE);
    }
}
