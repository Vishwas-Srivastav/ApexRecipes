/**
 * @description       : A basic template for creating Apex classes. It shows how to use constructors, define variables, and organize methods with a clear structure for public and private logic.
 * @author            : Vishwas Srivastav
 * @group             : 
 * @last modified on  : 08-21-2025
 * @last modified by  : Vishwas Srivastav
**/
public with sharing class ApexClassBoilerplate {
    
    private String inputValue;

    public BoilerplateClass(String inputValue) {
        this.inputValue = inputValue;
    }

    public void executeLogic() {
        System.debug('Executing logic with: ' + inputValue);
    }

    private Boolean validateInput() {
        return String.isNotBlank(inputValue);
    }
}
