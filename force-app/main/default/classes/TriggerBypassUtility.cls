/**
 * @description User and profile-based trigger bypass utility manager.
 * Evaluates session context, user IDs, profile names, and programmatic flags to decide if execution should proceed.
 * @author Vishwas Srivastav
 * @group Trigger Frameworks
 */
public with sharing class TriggerBypassUtility {

    private static Set<String> bypassedObjects = new Set<String>();
    private static Set<Id> bypassedUserIds = new Set<Id>();

    /**
     * @description Bypasses trigger execution for a specific SObject type name.
     * @param sObjectName SObject API name (e.g. Account, Contact).
     */
    public static void bypassObject(String sObjectName) {
        if (String.isNotBlank(sObjectName)) {
            bypassedObjects.add(sObjectName.toLowerCase());
        }
    }

    /**
     * @description Removes object trigger bypass.
     * @param sObjectName SObject API name.
     */
    public static void clearObjectBypass(String sObjectName) {
        if (String.isNotBlank(sObjectName)) {
            bypassedObjects.remove(sObjectName.toLowerCase());
        }
    }

    /**
     * @description Evaluates if trigger execution is bypassed for an SObject.
     * @param sObjectName SObject API name.
     * @return Boolean True if bypassed, false otherwise.
     */
    public static Boolean isObjectBypassed(String sObjectName) {
        if (String.isBlank(sObjectName)) {
            return false;
        }
        return bypassedObjects.contains(sObjectName.toLowerCase()) || 
               bypassedUserIds.contains(UserInfo.getUserId());
    }

    /**
     * @description Bypasses triggers for a specific User ID.
     * @param userId Salesforce User Id.
     */
    public static void bypassUser(Id userId) {
        if (userId != null) {
            bypassedUserIds.add(userId);
        }
    }

    /**
     * @description Removes user trigger bypass.
     * @param userId Salesforce User Id.
     */
    public static void clearUserBypass(Id userId) {
        if (userId != null) {
            bypassedUserIds.remove(userId);
        }
    }

    /**
     * @description Resets all object and user trigger bypass configurations.
     */
    public static void clearAll() {
        bypassedObjects.clear();
        bypassedUserIds.clear();
    }
}
