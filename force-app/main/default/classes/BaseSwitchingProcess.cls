public abstract class BaseSwitchingProcess {
    protected Switching_Request__c request;
    
    public BaseSwitchingProcess(Switching_Request__c request) {
        this.request = request;
    }
    
    public abstract void execute();
    public abstract void handleRejection(String reason);
    public abstract void validate();
    public abstract String generateXML();
    public abstract void processResponse(String response);
    public abstract String getProcessType();
    
    protected virtual void updateServiceStatus(String status) {
        request.Status__c = status;
        update request;
    }
    
    protected virtual void handleError(Exception e) {
        updateServiceStatus('Error');
        createNotification('Error', e.getMessage());
    }
    
    protected virtual void createNotification(String type, String message) {
        Switching_Notification__c notification = new Switching_Notification__c(
            Request__c = request.Id,
            Type__c = type,
            Message__c = message
        );
        insert notification;
    }
    
    protected void logProcess(String message, String level) {
        // Implementar sistema de logging
        System.debug(level + ': ' + message);
    }
}