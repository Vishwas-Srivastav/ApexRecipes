/**
 * @description Unit tests for OpportunityService.
 * @author Vishwas Srivastav
 * @group Enterprise Architecture Patterns
 */
@IsTest
private class OpportunityServiceTest {

    @IsTest
    static void testApplyVolumeDiscount() {
        Opportunity opp = new Opportunity(
            Name = 'Service Discount Test',
            StageName = 'Prospecting',
            CloseDate = Date.today().addDays(30),
            Amount = 10000.00
        );
        insert opp;

        Test.startTest();
        OpportunityService.applyVolumeDiscount(new Set<Id>{ opp.Id }, 10.0);
        Test.stopTest();

        Opportunity updatedOpp = [SELECT Id, Amount FROM Opportunity WHERE Id = :opp.Id];
        Assert.areEqual(9000.00, updatedOpp.Amount, 'Amount should reflect 10% discount');
    }
}
