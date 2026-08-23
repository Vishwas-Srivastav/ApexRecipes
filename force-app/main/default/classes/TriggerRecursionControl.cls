/**
 * @description Static transaction recursion controller ensuring trigger handler actions execute only once per record or event.
 * @author Vishwas Srivastav
 * @group Trigger Frameworks
 * @example
 * if (TriggerRecursionControl.hasExecuted('AccountUpdate', recordId)) {
 *     return;
 * }
 * TriggerRecursionControl.markExecuted('AccountUpdate', recordId);
 */
public with sharing class TriggerRecursionControl {

    private static Map<String, Set<Id>> executedKeyToRecordIdsMap = new Map<String, Set<Id>>();
    private static Map<String, Integer> executedKeyToCountMap = new Map<String, Integer>();
    private static final Integer DEFAULT_MAX_RUNS = 1;

    /**
     * @description Checks whether an action has already executed for a specific record ID.
     * @param actionKey Unique identifier for the trigger action or logic block.
     * @param recordId SObject Record ID.
     * @return Boolean True if already executed, false otherwise.
     */
    public static Boolean hasExecuted(String actionKey, Id recordId) {
        if (String.isBlank(actionKey) || recordId == null) {
            return false;
        }
        return executedKeyToRecordIdsMap.containsKey(actionKey) && 
               executedKeyToRecordIdsMap.get(actionKey).contains(recordId);
    }

    /**
     * @description Marks a record ID as processed for a specified action key.
     * @param actionKey Unique identifier for the trigger action.
     * @param recordId SObject Record ID.
     */
    public static void markExecuted(String actionKey, Id recordId) {
        if (String.isBlank(actionKey) || recordId == null) {
            return;
        }
        if (!executedKeyToRecordIdsMap.containsKey(actionKey)) {
            executedKeyToRecordIdsMap.put(actionKey, new Set<Id>());
        }
        executedKeyToRecordIdsMap.get(actionKey).add(recordId);
    }

    /**
     * @description Checks if global invocation count for an action key exceeds max allowed runs.
     * @param actionKey Unique identifier for the trigger action.
     * @param maxRuns Maximum allowed execution iterations.
     * @return Boolean True if execution count exceeded max allowed runs.
     */
    public static Boolean hasExceededMaxRuns(String actionKey, Integer maxRuns) {
        if (String.isBlank(actionKey)) {
            return false;
        }
        Integer currentCount = executedKeyToCountMap.containsKey(actionKey) ? executedKeyToCountMap.get(actionKey) : 0;
        Integer limitThreshold = (maxRuns != null && maxRuns > 0) ? maxRuns : DEFAULT_MAX_RUNS;
        return currentCount >= limitThreshold;
    }

    /**
     * @description Increments execution counter for an action key.
     * @param actionKey Unique identifier for the trigger action.
     */
    public static void incrementRunCount(String actionKey) {
        if (String.isBlank(actionKey)) {
            return;
        }
        Integer currentCount = executedKeyToCountMap.containsKey(actionKey) ? executedKeyToCountMap.get(actionKey) : 0;
        executedKeyToCountMap.put(actionKey, currentCount + 1);
    }

    /**
     * @description Resets tracking maps for unit testing or boundary resetting.
     */
    public static void resetAll() {
        executedKeyToRecordIdsMap.clear();
        executedKeyToCountMap.clear();
    }
}
