public class Switching_Service {
    private IDistributorIntegration integration;
    
    public Switching_Service(IDistributorIntegration integration) {
        this.integration = integration;
    }
    
    public void processRequest(Switching_Request__c request) {
        if (!integration.validateRequest(request)) {
            throw new SwitchingException('Invalid request');
        }
        
        integration.processRequest();
    }
    
    public static void sendRequest(List<Switching_Request__c> requests) {
        for (Switching_Request__c request : requests) {
            IDistributorIntegration integration = DistributorIntegrationFactory.getIntegration(request);
            Switching_Service service = new Switching_Service(integration);
            service.processRequest(request);
        }
    }
    
    public void processResponse() {
        integration.processResponse();
    }
    
    public class SwitchingException extends Exception {}
} 