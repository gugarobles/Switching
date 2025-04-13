public class SwitchingRetryHandler {
    private static final Integer MAX_RETRIES = 3;
    private static final Integer RETRY_DELAY_MINUTES = 5;
    
    public static void handleRetry(List<Switching_Request__c> requests) {
        List<Switching_Request__c> requestsToUpdate = new List<Switching_Request__c>();
        
        for(Switching_Request__c request : requests) {
            if(request.Retry_Count__c == null) {
                request.Retry_Count__c = 0;
            }
            
            if(request.Retry_Count__c < MAX_RETRIES) {
                request.Retry_Count__c++;
                request.Status__c = 'Pending';
                request.Next_Retry_Date__c = System.now().addMinutes(RETRY_DELAY_MINUTES);
                requestsToUpdate.add(request);
            } else {
                request.Status__c = 'Error';
                request.Error_Message__c = 'Maximum retry attempts reached';
                requestsToUpdate.add(request);
            }
        }
        
        if(!requestsToUpdate.isEmpty()) {
            update requestsToUpdate;
        }
    }
    
    public static void resetRetryCount(List<Switching_Request__c> requests) {
        for(Switching_Request__c request : requests) {
            request.Retry_Count__c = 0;
            request.Next_Retry_Date__c = null;
            request.Error_Message__c = null;
        }
    }
    
    public static Boolean shouldRetry(Switching_Request__c request) {
        return request.Retry_Count__c < MAX_RETRIES;
    }
    
    public static Boolean isReadyForRetry(Switching_Request__c request) {
        if(request.Next_Retry_Date__c == null) {
            return false;
        }
        return System.now() >= request.Next_Retry_Date__c;
    }
    
    public static void retryFailedRequests() {
        List<Switching_Request__c> failedRequests = [
            SELECT Id, Status__c, Error_Message__c
            FROM Switching_Request__c
            WHERE Status__c = 'ERROR'
            AND Retry_Count__c < 3
        ];
        
        for(Switching_Request__c request : failedRequests) {
            retryRequest(request.Id);
        }
    }
    
    public static void retryRequest(Id requestId) {
        Switching_Request__c request = [
            SELECT Id, Status__c, Error_Message__c, Retry_Count__c
            FROM Switching_Request__c
            WHERE Id = :requestId
        ];
        
        request.Status__c = 'PENDING';
        request.Error_Message__c = null;
        request.Retry_Count__c = (request.Retry_Count__c == null) ? 1 : request.Retry_Count__c + 1;
        update request;
        
        // Publish event to restart the process
        Switching_Event__e event = new Switching_Event__e(
            RequestId__c = request.Id,
            Type__c = 'PROCESS_STARTED'
        );
        EventBus.publish(event);
    }
}