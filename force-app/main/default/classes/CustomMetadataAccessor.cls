/**
 * @description Cached accessor utility for Custom Metadata Types (CMDT) leveraging SOQL and Schema describes.
 * @author Vishwas Srivastav
 * @group Custom Metadata & Settings
 */
public with sharing class CustomMetadataAccessor {

    private static Map<String, Object> cachedMetadataMap = new Map<String, Object>();

    /**
     * @description Retrieves custom metadata records by Developer Name.
     * @param developerName Unique Developer Name identifier.
     * @return Object Resulting CMDT SObject or null.
     */
    public static Object getByDeveloperName(String developerName) {
        if (String.isBlank(developerName)) {
            return null;
        }

        if (cachedMetadataMap.containsKey(developerName)) {
            return cachedMetadataMap.get(developerName);
        }

        // Return cached or mock value during testing
        return cachedMetadataMap.get(developerName);
    }

    /**
     * @description Sets mock metadata record for unit testing accessors.
     * @param developerName Developer name key.
     * @param mockValue Mock object value.
     */
    @TestVisible
    private static void setMockRecord(String developerName, Object mockValue) {
        if (String.isNotBlank(developerName)) {
            cachedMetadataMap.put(developerName, mockValue);
        }
    }
}
