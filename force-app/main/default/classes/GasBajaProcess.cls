public with sharing class GasBajaProcess extends BaseSwitchingProcess {
    private static final String PROCESS_TYPE = 'BAJA_GAS';
    private static final String DISTRIBUTOR = 'NATURGY';
    
    private Switching_Request__c request;
    private Service__c service;
    
    public GasBajaProcess(Switching_Request__c request) {
        super(request);
        this.request = request;
        this.service = [SELECT Id, CUPS_Gas__c, Distributor__c FROM Service__c WHERE Id = :request.Service__c];
    }
    
    public override void execute() {
        try {
            validate();
            String xml = generateXML();
            processResponse(xml);
        } catch(Exception e) {
            handleError(e);
        }
    }
    
    public override void handleRejection(String reason) {
        updateServiceStatus('Rejected');
        createNotification('Error', reason);
    }
    
    public override void validate() {
        if(String.isBlank(service.CUPS_Gas__c)) {
            throw new SwitchingException('CUPS de gas es requerido');
        }
        if(service.Distributor__c == null) {
            throw new SwitchingException('Distribuidor es requerido');
        }
    }
    
    public override String generateXML() {
        // TODO: Implement XML generation
        return '';
    }
    
    public override void processResponse(String response) {
        updateServiceStatus('Processing');
    }
    
    public override String getProcessType() {
        return PROCESS_TYPE;
    }
    
    protected override void updateServiceStatus(String status) {
        request.Status__c = status;
        update request;
    }
    
    protected override void handleError(Exception e) {
        updateServiceStatus('Error');
        createNotification('Error', e.getMessage());
    }
    
    protected override void createNotification(String type, String message) {
        Switching_Notification__c notification = new Switching_Notification__c(
            Request__c = request.Id,
            Type__c = type,
            Message__c = message
        );
        insert notification;
    }
} 