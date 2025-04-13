public class SwitchingEventHandler {
    public static void handleEvent(Switching_Event__e event) {
        try {
            if (event.Event_Type__c == 'REQUEST_SENT') {
                handleRequestSent(event);
            } else if (event.Event_Type__c == 'RESPONSE_RECEIVED') {
                handleResponseReceived(event);
            } else if (event.Event_Type__c == 'ERROR') {
                handleError(event);
            }
        } catch (Exception e) {
            createErrorNotification('Error processing event: ' + e.getMessage());
        }
    }

    private static void handleRequestSent(Switching_Event__e event) {
        List<Switching_Request__c> requests = [SELECT Id, Status__c FROM Switching_Request__c WHERE Id = :event.Request_Id__c];
        if (!requests.isEmpty()) {
            requests[0].Status__c = 'Sent';
            update requests;
            createNotification('Request sent successfully', event.Message__c);
        }
    }

    private static void handleResponseReceived(Switching_Event__e event) {
        List<Switching_Request__c> requests = [SELECT Id, Status__c FROM Switching_Request__c WHERE Id = :event.Request_Id__c];
        if (!requests.isEmpty()) {
            requests[0].Status__c = 'Response Received';
            update requests;
            createNotification('Response received', event.Message__c);
        }
    }

    private static void handleError(Switching_Event__e event) {
        List<Switching_Request__c> requests = [SELECT Id, Status__c FROM Switching_Request__c WHERE Id = :event.Request_Id__c];
        if (!requests.isEmpty()) {
            requests[0].Status__c = 'Error';
            update requests;
            createErrorNotification(event.Message__c);
        }
    }

    private static void createNotification(String title, String message) {
        // Implementation for creating notifications
        System.debug('Notification - Title: ' + title + ', Message: ' + message);
    }

    private static void createErrorNotification(String message) {
        // Implementation for creating error notifications
        System.debug('Error Notification - Message: ' + message);
    }
}