public virtual class SwitchingProcess {
    protected Switching_Message__c message;
    
    public SwitchingProcess(Switching_Message__c msg) {
        this.message = msg;
    }
    
    public virtual void validate() {
        // Base validation logic
        if (String.isBlank(message.CUPS__c)) {
            throw new SwitchingException('CUPS is required');
        }
    }
    
    public virtual String generateXML() {
        // Base XML generation logic
        return XMLTemplateManager.generateXML(message);
    }
    
    public virtual void processResponse() {
        // Base response processing logic
    }
    
    public virtual void process() {
        // Base process logic
        validate();
        String xmlRequest = generateXML();
        message.Request_XML__c = xmlRequest;
        message.Status__c = 'Pending';
        update message;
    }
    
    public virtual void handleResponse() {
        // Base response handling logic
        processResponse();
    }
    
    public class SwitchingException extends Exception {}
}