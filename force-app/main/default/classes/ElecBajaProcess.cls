public with sharing class ElecBajaProcess extends BaseSwitchingProcess {
    private static final String PROCESS_TYPE = 'BAJA_ELECTRICIDAD';
    private static final String DISTRIBUTOR = 'NATURGY';
    
    private Service__c service;

    public ElecBajaProcess(Switching_Request__c request) {
        super(request);
        this.service = [SELECT Id, CUPS_Electricidad__c, Distributor__c FROM Service__c WHERE Id = :request.Service__c];
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
        if(String.isBlank(service.CUPS_Electricidad__c)) {
            throw new SwitchingException('CUPS de electricidad es requerido');
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
}