@isTest
private class SwitchingRetryHandlerTest {
    @testSetup
    static void setup() {
        // Crear datos de prueba
        Account testAccount = new Account(
            Name = 'Test Account'
        );
        insert testAccount;
        
        Service__c testService = new Service__c(
            Name = 'Test Service',
            CUPS__c = 'ES0123456789012345678901',
            Country__c = 'ES'
        );
        insert testService;
        
        Switching_Request__c testRequest = new Switching_Request__c(
            Service__c = testService.Id,
            Process_Type__c = 'ALTA_GAS',
            Country__c = 'ES',
            Status__c = 'Error',
            Retry_Count__c = 0
        );
        insert testRequest;
    }
    
    @isTest
    static void testRetryFailedRequests() {
        // Obtener los datos de prueba
        Switching_Request__c testRequest = [SELECT Id FROM Switching_Request__c LIMIT 1];
        
        Test.startTest();
        SwitchingRetryHandler.retryFailedRequests();
        Test.stopTest();
        
        // Verificar los resultados
        Switching_Request__c updatedRequest = [SELECT Id, Status__c, Retry_Count__c 
                                             FROM Switching_Request__c 
                                             WHERE Id = :testRequest.Id];
        System.assertEquals('Pending', updatedRequest.Status__c);
        System.assertEquals(1, updatedRequest.Retry_Count__c);
    }
} 