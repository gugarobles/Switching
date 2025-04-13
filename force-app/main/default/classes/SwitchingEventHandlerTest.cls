@isTest
public class SwitchingEventHandlerTest {
    @TestSetup
    static void setup() {
        Account testAccount = new Account(
            Name = 'Test Account'
        );
        insert testAccount;

        Service__c testService = new Service__c(
            Name = 'Test Service',
            AccountId__c = testAccount.Id
        );
        insert testService;

        Switching_Request__c testRequest = new Switching_Request__c(
            Service__c = testService.Id
        );
        insert testRequest;
    }

    @isTest
    static void testHandleEvent_Success() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        Service__c testService = [SELECT Id FROM Service__c WHERE AccountId__c = :testAccount.Id LIMIT 1];
        Switching_Request__c testRequest = [SELECT Id FROM Switching_Request__c WHERE Service__c = :testService.Id LIMIT 1];

        Test.startTest();
        Switching_Event__e event = new Switching_Event__e(
            Request__c = testRequest.Id,
            Event_Type__c = 'SUCCESS'
        );
        EventBus.publish(event);
        Test.stopTest();

        Switching_Request__c updatedRequest = [SELECT Id, Status__c FROM Switching_Request__c WHERE Id = :testRequest.Id];
        System.assertEquals('Completed', updatedRequest.Status__c);
    }

    @isTest
    static void testHandleEvent_Error() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        Service__c testService = [SELECT Id FROM Service__c WHERE AccountId__c = :testAccount.Id LIMIT 1];
        Switching_Request__c testRequest = [SELECT Id FROM Switching_Request__c WHERE Service__c = :testService.Id LIMIT 1];

        Test.startTest();
        Switching_Event__e event = new Switching_Event__e(
            Request__c = testRequest.Id,
            Event_Type__c = 'ERROR',
            Error_Message__c = 'Test Error'
        );
        EventBus.publish(event);
        Test.stopTest();

        Switching_Request__c updatedRequest = [SELECT Id, Status__c, Error_Message__c FROM Switching_Request__c WHERE Id = :testRequest.Id];
        System.assertEquals('Error', updatedRequest.Status__c);
        System.assertEquals('Test Error', updatedRequest.Error_Message__c);
    }

    @isTest
    static void testHandleEvent_Retry() {
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        Service__c testService = [SELECT Id FROM Service__c WHERE AccountId__c = :testAccount.Id LIMIT 1];
        Switching_Request__c testRequest = [SELECT Id FROM Switching_Request__c WHERE Service__c = :testService.Id LIMIT 1];

        Test.startTest();
        Switching_Event__e event = new Switching_Event__e(
            Request__c = testRequest.Id,
            Event_Type__c = 'RETRY'
        );
        EventBus.publish(event);
        Test.stopTest();

        Switching_Request__c updatedRequest = [SELECT Id, Status__c, Retry_Count__c FROM Switching_Request__c WHERE Id = :testRequest.Id];
        System.assertEquals('Retry', updatedRequest.Status__c);
        System.assertEquals(1, updatedRequest.Retry_Count__c);
    }
} 