/**
 * @description Real-time transaction governor limit monitor logging CPU time, heap size, and SOQL limits.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
public with sharing class GovernorLimitMonitor {

    /**
     * @description Evaluates current governor limit consumption.
     * @return Boolean True if any limit exceeds 80% threshold.
     */
    public static Boolean isThresholdExceeded() {
        Decimal cpuPercent = (Decimal.valueOf(Limits.getCpuTime()) / Decimal.valueOf(Limits.getLimitCpuTime())) * 100;
        Decimal heapPercent = (Decimal.valueOf(Limits.getHeapSize()) / Decimal.valueOf(Limits.getLimitHeapSize())) * 100;
        Decimal soqlPercent = (Decimal.valueOf(Limits.getQueries()) / Decimal.valueOf(Limits.getLimitQueries())) * 100;

        System.debug(LoggingLevel.INFO, 'Governor Limits Consumption - CPU: ' + cpuPercent + '%, Heap: ' + heapPercent + '%, SOQL: ' + soqlPercent + '%');

        return cpuPercent >= 80 || heapPercent >= 80 || soqlPercent >= 80;
    }
}
