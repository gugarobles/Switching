public class SwitchingErrorHandler {
    public static void handleError(Switching_Request__c request, Exception e) {
        // Crear evento de error
        Switching_Event__e event = new Switching_Event__e(
            Event_Type__c = 'Error_Occurred',
            Request_Id__c = request.Id,
            Message_Content__c = e.getMessage() + '\n' + e.getStackTraceString()
        );
        
        // Publicar evento
        EventBus.publish(event);
        
        // Actualizar solicitud
        request.Status__c = 'Error';
        request.Error_Message__c = e.getMessage();
        update request;
    }
    
    public static void handleError(Switching_Message__c message, Exception e) {
        // Crear evento de error
        Switching_Event__e event = new Switching_Event__e(
            Event_Type__c = 'Error_Occurred',
            Request_Id__c = message.Request__c,
            Message_Content__c = e.getMessage() + '\n' + e.getStackTraceString()
        );
        
        // Publicar evento
        EventBus.publish(event);
        
        // Actualizar mensaje
        message.Status__c = 'Error';
        update message;
    }

    public static void handleError(String requestId, String errorMessage) {
        try {
            Service__c service = [SELECT Id, Status__c, Error_Message__c 
                                FROM Service__c 
                                WHERE Id = :requestId];
            
            service.Status__c = 'Error';
            service.Error_Message__c = errorMessage;
            update service;
            
        } catch (Exception e) {
            System.debug('Error updating service status: ' + e.getMessage());
        }
    }
}