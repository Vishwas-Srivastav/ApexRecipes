/**
 * @description Unit tests for EmailServiceHandler.
 * @author Vishwas Srivastav
 * @group Security, Governance & Exceptions
 */
@IsTest
private class EmailServiceHandlerTest {

    @IsTest
    static void testHandleInboundEmail() {
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

        email.subject = 'Test Inbound Service Email';
        email.plainTextBody = 'Email service test body payload';
        email.fromAddress = 'user@example.com';

        EmailServiceHandler handler = new EmailServiceHandler();
        Messaging.InboundEmailResult result = handler.handleInboundEmail(email, env);

        Assert.isTrue(result.success, 'Inbound email result should be successful');
    }
}
