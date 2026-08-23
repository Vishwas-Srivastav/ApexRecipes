/**
 * @description Unit tests for TriggerRecursionControl class.
 * @author Vishwas Srivastav
 * @group Trigger Frameworks
 */
@IsTest
private class TriggerRecursionControlTest {

    @IsTest
    static void testRecordIdRecursionControl() {
        String actionKey = 'AccountStandardize';
        Id mockId = '001000000000001AAA';

        Assert.isFalse(TriggerRecursionControl.hasExecuted(actionKey, mockId), 'Should return false prior to marking');

        TriggerRecursionControl.markExecuted(actionKey, mockId);
        Assert.isTrue(TriggerRecursionControl.hasExecuted(actionKey, mockId), 'Should return true after marking');

        TriggerRecursionControl.resetAll();
        Assert.isFalse(TriggerRecursionControl.hasExecuted(actionKey, mockId), 'Should return false after reset');
    }

    @IsTest
    static void testRunCountLimitControl() {
        String actionKey = 'OpportunitySync';

        Assert.isFalse(TriggerRecursionControl.hasExceededMaxRuns(actionKey, 2), 'Should not exceed max runs initially');

        TriggerRecursionControl.incrementRunCount(actionKey);
        TriggerRecursionControl.incrementRunCount(actionKey);

        Assert.isTrue(TriggerRecursionControl.hasExceededMaxRuns(actionKey, 2), 'Should exceed max runs after 2 increments');
    }
}
