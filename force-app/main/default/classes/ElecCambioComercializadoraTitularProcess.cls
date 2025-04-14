public class ElecCambioComercializadoraTitularProcess {
    private final Switching_Request__c request;
    private final Service__c service;
    private final Account account;

    public ElecCambioComercializadoraTitularProcess(Switching_Request__c request) {
        this.request = request;
        this.service = [SELECT Id, CUPS__c FROM Service__c WHERE Id = :request.Service__c];
        this.account = [SELECT Id FROM Account WHERE Id = :service.AccountId__c];
    }

    public void execute() {
        try {
            validateRequest();
            processRequest();
            updateRequestStatus();
        } catch (Exception e) {
            handleError(e);
        }
    }

    private void validateRequest() {
        if (request == null) {
            throw new SwitchingException('Request cannot be null');
        }
        if (service == null) {
            throw new SwitchingException('Service cannot be null');
        }
        if (String.isBlank(service.CUPS__c)) {
            throw new SwitchingException('CUPS is required');
        }
    }

    private void processRequest() {
        // Implementar la lógica específica del proceso
    }

    private void updateRequestStatus() {
        request.Status__c = 'Processing';
        update request;
    }

    private void handleError(Exception e) {
        request.Status__c = 'Error';
        request.Error_Message__c = e.getMessage();
        update request;
    }

    public class SwitchingException extends Exception {}
}