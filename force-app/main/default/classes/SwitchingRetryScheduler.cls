public class SwitchingRetryScheduler implements Schedulable {
    private Id requestId;
    
    public SwitchingRetryScheduler(Id requestId) {
        this.requestId = requestId;
    }
    
    public void execute(SchedulableContext sc) {
        SwitchingRetryHandler.retryRequest(requestId);
    }
}