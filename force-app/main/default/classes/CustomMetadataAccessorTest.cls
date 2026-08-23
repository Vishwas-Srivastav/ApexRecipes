/**
 * @description Unit tests for CustomMetadataAccessor.
 * @author Vishwas Srivastav
 * @group Custom Metadata & Settings
 */
@IsTest
private class CustomMetadataAccessorTest {

    @IsTest
    static void testGetByDeveloperName() {
        String key = 'TestConfigKey';
        String mockData = 'MockConfigurationValue';

        CustomMetadataAccessor.setMockRecord(key, mockData);

        Object result = CustomMetadataAccessor.getByDeveloperName(key);
        Assert.isNotNull(result, 'Accessor should return cached mock record');
        Assert.areEqual(mockData, (String) result, 'Mock data string should match input');
    }
}
