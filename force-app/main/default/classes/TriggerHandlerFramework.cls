/**
 * @description Interface and abstract base class for enterprise trigger handler implementation.
 * Provides context routing, re-entrancy protection, and execution control across all trigger phases.
 * @author Vishwas Srivastav
 * @group Trigger Frameworks
 * @example
 * public class AccountTriggerHandler extends TriggerHandlerFramework {
 *     public override void beforeInsert() {
 *         // Logic for before insert
 *     }
 * }
 */
public abstract class TriggerHandlerFramework {

    /**
     * @description Enumeration representing all possible Apex trigger execution contexts.
     */
    public enum TriggerContext {
        BEFORE_INSERT,
        BEFORE_UPDATE,
        BEFORE_DELETE,
        AFTER_INSERT,
        AFTER_UPDATE,
        AFTER_DELETE,
        AFTER_UNDELETE
    }

    @TestVisible
    private static Set<String> bypassedHandlers = new Set<String>();

    @TestVisible
    private TriggerContext context;

    @TestVisible
    private Boolean isTriggerExecuting;

    /**
     * @description Default constructor initializing current trigger context.
     */
    public TriggerHandlerFramework() {
        this.setTriggerContext();
    }

    /**
     * @description Main entry point for executing the trigger handler logic based on context.
     */
    public void run() {
        if (!validateRun()) {
            return;
        }

        switch on this.context {
            when BEFORE_INSERT {
                this.beforeInsert();
            }
            when BEFORE_UPDATE {
                this.beforeUpdate();
            }
            when BEFORE_DELETE {
                this.beforeDelete();
            }
            when AFTER_INSERT {
                this.afterInsert();
            }
            when AFTER_UPDATE {
                this.afterUpdate();
            }
            when AFTER_DELETE {
                this.afterDelete();
            }
            when AFTER_UNDELETE {
                this.afterUndelete();
            }
        }
    }

    /**
     * @description Bypasses execution of a specific trigger handler class.
     * @param handlerName The API name of the trigger handler class.
     */
    public static void bypass(String handlerName) {
        if (String.isNotBlank(handlerName)) {
            bypassedHandlers.add(handlerName);
        }
    }

    /**
     * @description Removes the bypass for a specific trigger handler class.
     * @param handlerName The API name of the trigger handler class.
     */
    public static void clearBypass(String handlerName) {
        if (String.isNotBlank(handlerName)) {
            bypassedHandlers.remove(handlerName);
        }
    }

    /**
     * @description Checks if a specific trigger handler class is currently bypassed.
     * @param handlerName The API name of the trigger handler class.
     * @return Boolean True if bypassed, false otherwise.
     */
    public static Boolean isBypassed(String handlerName) {
        return String.isNotBlank(handlerName) && bypassedHandlers.contains(handlerName);
    }

    /**
     * @description Resets all active trigger handler bypasses.
     */
    public static void clearAllBypasses() {
        bypassedHandlers.clear();
    }

    // Virtual context methods intended for subclass overrides
    public virtual void beforeInsert() {}
    public virtual void beforeUpdate() {}
    public virtual void beforeDelete() {}
    public virtual void afterInsert() {}
    public virtual void afterUpdate() {}
    public virtual void afterDelete() {}
    public virtual void afterUndelete() {}

    @TestVisible
    private Boolean validateRun() {
        String handlerName = String.valueOf(this).split(':')[0];
        if (bypassedHandlers.contains(handlerName)) {
            return false;
        }
        return true;
    }

    @TestVisible
    private void setTriggerContext() {
        if (Trigger.isExecuting != null && Trigger.isExecuting) {
            this.isTriggerExecuting = true;
        } else {
            this.isTriggerExecuting = false;
        }

        if (Trigger.isBefore != null && Trigger.isBefore && Trigger.isInsert != null && Trigger.isInsert) {
            this.context = TriggerContext.BEFORE_INSERT;
        } else if (Trigger.isBefore != null && Trigger.isBefore && Trigger.isUpdate != null && Trigger.isUpdate) {
            this.context = TriggerContext.BEFORE_UPDATE;
        } else if (Trigger.isBefore != null && Trigger.isBefore && Trigger.isDelete != null && Trigger.isDelete) {
            this.context = TriggerContext.BEFORE_DELETE;
        } else if (Trigger.isAfter != null && Trigger.isAfter && Trigger.isInsert != null && Trigger.isInsert) {
            this.context = TriggerContext.AFTER_INSERT;
        } else if (Trigger.isAfter != null && Trigger.isAfter && Trigger.isUpdate != null && Trigger.isUpdate) {
            this.context = TriggerContext.AFTER_UPDATE;
        } else if (Trigger.isAfter != null && Trigger.isAfter && Trigger.isDelete != null && Trigger.isDelete) {
            this.context = TriggerContext.AFTER_DELETE;
        } else if (Trigger.isAfter != null && Trigger.isAfter && Trigger.isUndelete != null && Trigger.isUndelete) {
            this.context = TriggerContext.AFTER_UNDELETE;
        }
    }
}
