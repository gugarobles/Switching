@isTest
public class SwitchingServiceTest {
    @TestSetup
    static void setup() {
        Account testAccount = new Account(
            Name = 'Test Account'
        );
        insert testAccount;

        Service__c testService = new Service__c(
            Name = 'Test Service',
            AccountId__c = testAccount.Id,
            Country__c = 'ES'
        );
        insert testService;

        Switching_Configuration__c testConfig = new Switching_Configuration__c(
            Name = 'Test Config',
            Distributor__c = 'NATURGY',
            Process_Type__c = 'B1',
            Integration_Class__c = 'NaturgyIntegration',
            Active__c = true
        );
        insert testConfig;
    }

    @isTest
    static void testProcessRequest() {
        // Create test data
        Service__c testService = [SELECT Id FROM Service__c LIMIT 1];
        Switching_Request__c request = new Switching_Request__c(
            Process_Type__c = 'B1',
            ServiceId__c = testService.Id,
            Distributor__c = 'NATURGY'
        );
        insert request;
        
        // Create mock integration
        MockDistributorIntegration mockIntegration = new MockDistributorIntegration();
        mockIntegration.request = request;
        
        // Create service instance
        Switching_Service service = new Switching_Service(mockIntegration);
        
        Test.startTest();
        service.processRequest(request);
        Test.stopTest();
        
        // Verify the mock was called
        System.assert(mockIntegration.processRequestCalled, 'processRequest should have been called');
    }
    
    private class MockDistributorIntegration implements IDistributorIntegration {
        public Boolean processRequestCalled = false;
        private Switching_Configuration__c config;
        public Switching_Request__c request;
        
        public void sendRequest() {}
        public void processResponse() {}
        public String generateRequest() { return ''; }
        public String getCountry() { return 'ES'; }
        public String getProcessType() { return 'B1'; }
        
        public void processRequest() {
            processRequestCalled = true;
        }
        
        public Boolean validateRequest(Switching_Request__c request) {
            return true;
        }
        
        public Switching_Configuration__c getConfiguration() {
            if (config == null) {
                config = new Switching_Configuration__c(
                    Name = 'Test Config',
                    Distributor__c = 'NATURGY',
                    Process_Type__c = 'B1',
                    Active__c = true
                );
            }
            return config;
        }
    }
} 