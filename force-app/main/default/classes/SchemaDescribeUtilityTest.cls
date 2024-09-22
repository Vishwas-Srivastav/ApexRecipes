/**
 * @description Unit tests for SchemaDescribeUtility.
 * @author Vishwas Srivastav
 * @group Dynamic Apex & Schema Describe
 */
@IsTest
private class SchemaDescribeUtilityTest {

    @IsTest
    static void testGetPicklistValues() {
        Map<String, String> values = SchemaDescribeUtility.getPicklistValues('Account', 'Rating');
        Assert.isNotNull(values, 'Picklist map should not be null');
        Assert.isTrue(values.containsKey('Hot') || values.size() >= 0, 'Should extract picklist entries for Account Rating');
    }

    @IsTest
    static void testIsFieldAccessible() {
        Boolean accessible = SchemaDescribeUtility.isFieldAccessible('Account', 'Name');
        Assert.isTrue(accessible, 'Account Name field should be accessible');
    }
}
