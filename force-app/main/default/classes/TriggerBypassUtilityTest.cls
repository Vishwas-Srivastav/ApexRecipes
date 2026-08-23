/**
 * @description Unit tests for TriggerBypassUtility.
 * @author Vishwas Srivastav
 * @group Trigger Frameworks
 */
@IsTest
private class TriggerBypassUtilityTest {

    @IsTest
    static void testObjectBypass() {
        String objName = 'Account';
        Assert.isFalse(TriggerBypassUtility.isObjectBypassed(objName), 'Account should not be bypassed');

        TriggerBypassUtility.bypassObject(objName);
        Assert.isTrue(TriggerBypassUtility.isObjectBypassed(objName), 'Account should be bypassed');

        TriggerBypassUtility.clearObjectBypass(objName);
        Assert.isFalse(TriggerBypassUtility.isObjectBypassed(objName), 'Account should no longer be bypassed');
    }

    @IsTest
    static void testUserBypass() {
        Id currentUserId = UserInfo.getUserId();
        String objName = 'Contact';

        Assert.isFalse(TriggerBypassUtility.isObjectBypassed(objName), 'Should not be bypassed initially');

        TriggerBypassUtility.bypassUser(currentUserId);
        Assert.isTrue(TriggerBypassUtility.isObjectBypassed(objName), 'Should be bypassed due to user bypass');

        TriggerBypassUtility.clearUserBypass(currentUserId);
        Assert.isFalse(TriggerBypassUtility.isObjectBypassed(objName), 'User bypass should be cleared');

        TriggerBypassUtility.bypassObject(objName);
        TriggerBypassUtility.clearAll();
        Assert.isFalse(TriggerBypassUtility.isObjectBypassed(objName), 'All bypasses should be cleared');
    }
}
