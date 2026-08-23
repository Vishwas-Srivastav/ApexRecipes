/**
 * @description Unit tests for GovernorLimitMonitor.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
@IsTest
private class GovernorLimitMonitorTest {

    @IsTest
    static void testIsThresholdExceeded() {
        Boolean exceeded = GovernorLimitMonitor.isThresholdExceeded();
        Assert.isFalse(exceeded, 'Fresh transaction limits should not exceed 80% threshold');
    }
}
