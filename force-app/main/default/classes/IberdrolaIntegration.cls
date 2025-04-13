public class IberdrolaIntegration extends BaseDistributorIntegration {
    private static final String DISTRIBUTOR = 'IBERDROLA';
    
    public IberdrolaIntegration(Switching_Configuration__c config) {
        super(config);
    }
    
    public override Boolean validateRequest(Switching_Request__c request) {
        // TODO: Implement Iberdrola-specific request validation logic
        return true;
    }
    
    public override String generateRequest() {
        // TODO: Implement Iberdrola-specific request generation logic
        return '';
    }
    
    public override void sendRequest() {
        // TODO: Implement Iberdrola-specific request sending logic
    }
    
    public override void processResponse() {
        // TODO: Implement Iberdrola-specific response processing logic
    }
    
    public override String getCountry() {
        return 'ES';
    }
    
    public override String getProcessType() {
        return request.Process_Type__c;
    }
    
    public override void processRequest() {
        // Implementar la lógica específica para Iberdrola
        System.debug('Processing request for Iberdrola: ' + request.Id);
    }
}