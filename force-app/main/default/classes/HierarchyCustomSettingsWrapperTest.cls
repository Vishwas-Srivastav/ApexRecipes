/**
 * @description Unit tests for HierarchyCustomSettingsWrapper.
 * @author Vishwas Srivastav
 * @group Custom Metadata & Settings
 */
@IsTest
private class HierarchyCustomSettingsWrapperTest {

    @IsTest
    static void testIsFeatureEnabled() {
        HierarchyCustomSettingsWrapper.mockFeatureEnabled = true;
        Assert.isTrue(HierarchyCustomSettingsWrapper.isFeatureEnabled('NewUI'), 'Feature should return true when enabled');

        HierarchyCustomSettingsWrapper.mockFeatureEnabled = false;
        Assert.isFalse(HierarchyCustomSettingsWrapper.isFeatureEnabled('NewUI'), 'Feature should return false when disabled');
    }
}
