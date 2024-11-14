/**
 * @description Centralized exception logging framework capturing stack traces, line numbers, apex class names, and user context.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
public with sharing class ExceptionLoggerService {

    @TestVisible
    private static List<String> loggedErrors = new List<String>();

    /**
     * @description Logs Exception details into persistent store or debug logs.
     * @param ex System Exception instance.
     * @param contextClassName Class or component context.
     */
    public static void logException(Exception ex, String contextClassName) {
        if (ex == null) {
            return;
        }

        String logPayload = 'Class: ' + contextClassName + 
                           ' | Message: ' + ex.getMessage() + 
                           ' | Line: ' + ex.getLineNumber() + 
                           ' | Trace: ' + ex.getStackTraceString();

        loggedErrors.add(logPayload);
        System.debug(LoggingLevel.ERROR, 'Exception Logged: ' + logPayload);
    }
}
