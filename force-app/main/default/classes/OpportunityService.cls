/**
 * @description Service layer pattern orchestrating transactional business logic for Opportunity records.
 * @author Vishwas Srivastav
 * @group Enterprise Architecture Patterns
 */
public with sharing class OpportunityService {

    /**
     * @description Applies volume discount to opportunities matching threshold criteria.
     * @param oppIds Collection of Opportunity Record IDs.
     * @param discountPercentage Percentage discount value to apply.
     */
    public static void applyVolumeDiscount(Set<Id> oppIds, Decimal discountPercentage) {
        if (oppIds == null || oppIds.isEmpty() || discountPercentage == null || discountPercentage <= 0) {
            return;
        }

        List<Opportunity> oppsToUpdate = [
            SELECT Id, Amount, Description 
            FROM Opportunity 
            WHERE Id IN :oppIds 
            WITH USER_MODE
        ];

        for (Opportunity opp : oppsToUpdate) {
            if (opp.Amount != null && opp.Amount > 0) {
                opp.Amount = opp.Amount * (1 - (discountPercentage / 100));
                opp.Description = 'Volume discount of ' + discountPercentage + '% applied.';
            }
        }

        if (!oppsToUpdate.isEmpty()) {
            Database.update(oppsToUpdate, AccessLevel.USER_MODE);
        }
    }
}
