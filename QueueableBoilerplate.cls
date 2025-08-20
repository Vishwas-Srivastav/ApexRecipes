/**
 * @description       : A simple structure for Queueable Apex jobs. Supports parameterized execution and job chaining, making it useful for lightweight async tasks or callouts.
 * @author            : Vishwas Srivastav
 * @group             : 
 * @last modified on  : 08-21-2025
 * @last modified by  : Vishwas Srivastav
**/
public class QueueableBoilerplate implements Queueable {
    
    private Id recordId;

    public QueueableBoilerplate(Id recordId) {
        this.recordId = recordId;
    }

    public void execute(QueueableContext context) {
        // Example logic
        System.debug('Processing record: ' + recordId);
    }
}

//➡ Run with: System.enqueueJob(new QueueableBoilerplate('001XXXXXXXXXXXX'));
