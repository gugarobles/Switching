public class NaturgyIntegration extends BaseDistributorIntegration {
    private static final String DISTRIBUTOR = 'NATURGY';
    
    public NaturgyIntegration(Switching_Configuration__c config) {
        super(config);
    }
    
    public override Boolean validateRequest(Switching_Request__c request) {
        // TODO: Implement Naturgy-specific request validation logic
        return true;
    }
    
    public override String generateRequest() {
        // TODO: Implement Naturgy-specific request generation logic
        return '';
    }
    
    public override void sendRequest() {
        // TODO: Implement Naturgy-specific request sending logic
    }
    
    public override void processResponse() {
        // TODO: Implement Naturgy-specific response processing logic
    }
    
    public override String getCountry() {
        return 'ES';
    }
    
    public override String getProcessType() {
        return request.Process_Type__c;
    }
    
    public override void processRequest() {
        // Implementar la lógica específica para Naturgy
        System.debug('Processing request for Naturgy: ' + request.Id);
    }
}