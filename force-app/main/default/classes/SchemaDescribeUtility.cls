/**
 * @description Dynamic field describe, picklist value extractor, and SObject metadata reflection utility.
 * @author Vishwas Srivastav
 * @group Dynamic Apex & Schema Describe
 */
public with sharing class SchemaDescribeUtility {

    /**
     * @description Extracts picklist label and value pairs for a given SObject and field.
     * @param sObjectName SObject API name.
     * @param fieldName Field API name.
     * @return Map<String, String> Map of picklist values to picklist labels.
     */
    public static Map<String, String> getPicklistValues(String sObjectName, String fieldName) {
        Map<String, String> options = new Map<String, String>();
        if (String.isBlank(sObjectName) || String.isBlank(fieldName)) {
            return options;
        }

        Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(sObjectName);
        if (sObjectType == null) {
            return options;
        }

        Schema.DescribeSObjectResult describeResult = sObjectType.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = describeResult.fields.getMap();

        if (!fieldMap.containsKey(fieldName)) {
            return options;
        }

        List<Schema.PicklistEntry> entries = fieldMap.get(fieldName).getDescribe().getPicklistValues();
        for (Schema.PicklistEntry entry : entries) {
            if (entry.isActive()) {
                options.put(entry.getValue(), entry.getLabel());
            }
        }
        return options;
    }

    /**
     * @description Checks field accessibility for current user.
     * @param sObjectName SObject API name.
     * @param fieldName Field API name.
     * @return Boolean True if field is accessible.
     */
    public static Boolean isFieldAccessible(String sObjectName, String fieldName) {
        if (String.isBlank(sObjectName) || String.isBlank(fieldName)) {
            return false;
        }
        Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(sObjectName);
        if (sObjectType == null) {
            return false;
        }
        Map<String, Schema.SObjectField> fieldMap = sObjectType.getDescribe().fields.getMap();
        return fieldMap.containsKey(fieldName) && fieldMap.get(fieldName).getDescribe().isAccessible();
    }
}
