@isTest
private class SwitchingErrorHandlerTest {
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
            Country__c = 'ES'
        );
        insert testRequest;
    }
    
    @isTest
    static void testHandleError() {
        // Obtener los datos de prueba
        Switching_Request__c testRequest = [SELECT Id FROM Switching_Request__c LIMIT 1];
        
        Test.startTest();
        SwitchingErrorHandler.handleError(testRequest.Id, 'Test Error');
        Test.stopTest();
        
        // Verificar los resultados
        Switching_Request__c updatedRequest = [SELECT Id, Status__c, Error_Message__c 
                                             FROM Switching_Request__c 
                                             WHERE Id = :testRequest.Id];
        System.assertEquals('Error', updatedRequest.Status__c);
        System.assertEquals('Test Error', updatedRequest.Error_Message__c);
    }

    @isTest
    static void testHandleMessageError() {
        Switching_Request__c request = [SELECT Id FROM Switching_Request__c LIMIT 1];
        Switching_Message__c message = new Switching_Message__c(
            Request__c = request.Id,
            Status__c = 'Pending'
        );
        insert message;
        
        Test.startTest();
        try {
            throw new SwitchingException('Test exception');
        } catch (Exception e) {
            SwitchingErrorHandler.handleError(message, e);
        }
        Test.stopTest();

        message = [SELECT Id, Status__c FROM Switching_Message__c WHERE Id = :message.Id];
        System.assertEquals('Error', message.Status__c, 'Status should be Error');
    }
} 