@isTest
private class SwitchingEventTriggerTest {
    @isTest
    static void testErrorEvent() {
        // Create test event
        Switching_Event__e event = new Switching_Event__e(
            Event_Type__c = 'Error_Occurred',
            Message_Content__c = 'Test error message'
        );
        
        Test.startTest();
        // Publish event
        Database.SaveResult sr = EventBus.publish(event);
        Test.stopTest();
        
        // Verify notification was created
        List<Switching_Notification__c> notifications = [
            SELECT Type__c, Message__c 
            FROM Switching_Notification__c
        ];
        
        System.assertEquals(1, notifications.size(), 'Should have created one notification');
        System.assertEquals('Error', notifications[0].Type__c, 'Notification type should be Error');
        System.assertEquals('Test error message', notifications[0].Message__c, 'Message should match');
    }
    
    @isTest
    static void testSuccessEvent() {
        // Create test event
        Switching_Event__e event = new Switching_Event__e(
            Event_Type__c = 'Request_Completed',
            Message_Content__c = 'Test success message'
        );
        
        Test.startTest();
        // Publish event
        Database.SaveResult sr = EventBus.publish(event);
        Test.stopTest();
        
        // Verify notification was created
        List<Switching_Notification__c> notifications = [
            SELECT Type__c, Message__c 
            FROM Switching_Notification__c
        ];
        
        System.assertEquals(1, notifications.size(), 'Should have created one notification');
        System.assertEquals('Success', notifications[0].Type__c, 'Notification type should be Success');
        System.assertEquals('Test success message', notifications[0].Message__c, 'Message should match');
    }
} 