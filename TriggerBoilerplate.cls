/**
 * @description       : A starter trigger template that includes all major contexts. It provides a clean structure for adding logic while encouraging the use of handler classes for maintainability.
 * @author            : Vishwas Srivastav
 * @group             : 
 * @last modified on  : 08-21-2025
 * @last modified by  : Vishwas Srivastav
**/
trigger TriggerBoilerplate on Account (before insert, before update, after insert, after update) {
    
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            // Before Insert logic
        }
        if (Trigger.isUpdate) {
            // Before Update logic
        }
    }

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            // After Insert logic
        }
        if (Trigger.isUpdate) {
            // After Update logic
        }
    }
}
