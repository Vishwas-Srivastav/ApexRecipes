/**
 * @description Unit tests for TriggerHandlerFramework class.
 * @author Vishwas Srivastav
 * @group Trigger Frameworks
 */
@IsTest
private class TriggerHandlerFrameworkTest {

    private class TestHandler extends TriggerHandlerFramework {
        public Boolean beforeInsertExecuted = false;
        public Boolean beforeUpdateExecuted = false;
        public Boolean beforeDeleteExecuted = false;
        public Boolean afterInsertExecuted = false;
        public Boolean afterUpdateExecuted = false;
        public Boolean afterDeleteExecuted = false;
        public Boolean afterUndeleteExecuted = false;

        public override void beforeInsert() {
            this.beforeInsertExecuted = true;
        }

        public override void beforeUpdate() {
            this.beforeUpdateExecuted = true;
        }

        public override void beforeDelete() {
            this.beforeDeleteExecuted = true;
        }

        public override void afterInsert() {
            this.afterInsertExecuted = true;
        }

        public override void afterUpdate() {
            this.afterUpdateExecuted = true;
        }

        public override void afterDelete() {
            this.afterDeleteExecuted = true;
        }

        public override void afterUndelete() {
            this.afterUndeleteExecuted = true;
        }
    }

    @IsTest
    static void testBypassManagement() {
        String handlerName = 'TestHandler';
        Assert.isFalse(TriggerHandlerFramework.isBypassed(handlerName), 'Handler should not be bypassed initially');

        TriggerHandlerFramework.bypass(handlerName);
        Assert.isTrue(TriggerHandlerFramework.isBypassed(handlerName), 'Handler should be bypassed');

        TriggerHandlerFramework.clearBypass(handlerName);
        Assert.isFalse(TriggerHandlerFramework.isBypassed(handlerName), 'Handler should no longer be bypassed');

        TriggerHandlerFramework.bypass(handlerName);
        TriggerHandlerFramework.clearAllBypasses();
        Assert.isFalse(TriggerHandlerFramework.isBypassed(handlerName), 'All bypasses should be cleared');
    }

    @IsTest
    static void testContextExecution() {
        TestHandler handler = new TestHandler();

        handler.context = TriggerHandlerFramework.TriggerContext.BEFORE_INSERT;
        handler.run();
        Assert.isTrue(handler.beforeInsertExecuted, 'Before insert logic should execute');

        handler.context = TriggerHandlerFramework.TriggerContext.BEFORE_UPDATE;
        handler.run();
        Assert.isTrue(handler.beforeUpdateExecuted, 'Before update logic should execute');

        handler.context = TriggerHandlerFramework.TriggerContext.BEFORE_DELETE;
        handler.run();
        Assert.isTrue(handler.beforeDeleteExecuted, 'Before delete logic should execute');

        handler.context = TriggerHandlerFramework.TriggerContext.AFTER_INSERT;
        handler.run();
        Assert.isTrue(handler.afterInsertExecuted, 'After insert logic should execute');

        handler.context = TriggerHandlerFramework.TriggerContext.AFTER_UPDATE;
        handler.run();
        Assert.isTrue(handler.afterUpdateExecuted, 'After update logic should execute');

        handler.context = TriggerHandlerFramework.TriggerContext.AFTER_DELETE;
        handler.run();
        Assert.isTrue(handler.afterDeleteExecuted, 'After delete logic should execute');

        handler.context = TriggerHandlerFramework.TriggerContext.AFTER_UNDELETE;
        handler.run();
        Assert.isTrue(handler.afterUndeleteExecuted, 'After undelete logic should execute');
    }

    @IsTest
    static void testBypassedRun() {
        TestHandler handler = new TestHandler();
        TriggerHandlerFramework.bypass('TestHandler');

        handler.context = TriggerHandlerFramework.TriggerContext.BEFORE_INSERT;
        handler.run();
        Assert.isFalse(handler.beforeInsertExecuted, 'Bypassed handler should not execute');
    }
}
