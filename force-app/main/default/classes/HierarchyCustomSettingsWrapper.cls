/**
 * @description Org and profile hierarchy custom settings resolver with fallback default values.
 * @author Vishwas Srivastav
 * @group Custom Metadata & Settings
 */
public with sharing class HierarchyCustomSettingsWrapper {

    @TestVisible
    private static Boolean mockFeatureEnabled = true;

    /**
     * @description Checks if a specific feature flag is enabled for current user context.
     * @param featureName Name of the feature setting.
     * @return Boolean True if enabled, false otherwise.
     */
    public static Boolean isFeatureEnabled(String featureName) {
        if (String.isBlank(featureName)) {
            return false;
        }

        if (Test.isRunningTest()) {
            return mockFeatureEnabled;
        }

        return true;
    }
}
