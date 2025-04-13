trigger SwitchingRequestTrigger on Switching_Request__c (after insert, after update) {
    List<Switching_Request__c> requestsToProcess = new List<Switching_Request__c>();
    
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            requestsToProcess.addAll(Trigger.new);
        } else if (Trigger.isUpdate) {
            for (Switching_Request__c request : Trigger.new) {
                Switching_Request__c oldRequest = Trigger.oldMap.get(request.Id);
                if (request.Status__c != oldRequest.Status__c) {
                    requestsToProcess.add(request);
                }
            }
        }
    }
    
    if (!requestsToProcess.isEmpty()) {
        Switching_Service.sendRequest(requestsToProcess);
    }
} 