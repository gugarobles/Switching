public abstract class BaseDistributorIntegration implements IDistributorIntegration {
    protected Switching_Configuration__c config;
    protected Switching_Request__c request;
    protected Switching_Message__c message;
    
    public BaseDistributorIntegration(Switching_Configuration__c config) {
        this.config = config;
    }
    
    public Switching_Configuration__c getConfiguration() {
        return this.config;
    }
    
    public abstract void sendRequest();
    public abstract void processResponse();
    public abstract String generateRequest();
    public abstract String getCountry();
    public abstract String getProcessType();
    public abstract void processRequest();
    
    public virtual Boolean validateRequest(Switching_Request__c request) {
        if (request == null) {
            return false;
        }
        
        if (String.isBlank(request.ServiceId__c) || 
            String.isBlank(request.Distributor__c) || 
            String.isBlank(request.Process_Type__c)) {
            return false;
        }
        
        return true;
    }
    
    protected Switching_Message__c createMessage(String messageType, String status, String content) {
        Switching_Message__c msg = new Switching_Message__c();
        msg.Request__c = request.Id;
        msg.Message_Type__c = messageType;
        msg.Status__c = status;
        msg.Message_Content__c = content;
        return msg;
    }
}