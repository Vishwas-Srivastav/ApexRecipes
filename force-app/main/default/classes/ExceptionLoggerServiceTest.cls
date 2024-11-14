/**
 * @description Unit tests for ExceptionLoggerService.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
@IsTest
private class ExceptionLoggerServiceTest {

    @IsTest
    static void testLogException() {
        try {
            Integer result = 1 / 0;
        } catch (Exception ex) {
            ExceptionLoggerService.logException(ex, 'ExceptionLoggerServiceTest');
            Assert.areEqual(1, ExceptionLoggerService.loggedErrors.size(), 'Should record 1 logged exception payload');
        }
    }
}
