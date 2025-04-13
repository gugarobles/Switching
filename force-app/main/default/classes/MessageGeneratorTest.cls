@isTest
private class MessageGeneratorTest {
    @TestSetup
    static void setup() {
        Account account = new Account(
            Name = 'Test Account',
            Phone = '1234567890',
            Email__c = 'test@example.com'
        );
        insert account;
    }

    @isTest
    static void testWelcomeMessage() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        
        Test.startTest();
        MessageGenerator.generateMessage(account.Id, 'WELCOME');
        Test.stopTest();

        List<Switching_Message__c> messages = [
            SELECT Id, Account__c, Type__c, Status__c, Email__c
            FROM Switching_Message__c
            WHERE Account__c = :account.Id
        ];
        
        System.assertEquals(1, messages.size(), 'Should have created one message');
        System.assertEquals('WELCOME', messages[0].Type__c, 'Message type should match');
        System.assertEquals('Pending', messages[0].Status__c, 'Status should be Pending');
        System.assertEquals('test@example.com', messages[0].Email__c, 'Email should match');
    }

    @isTest
    static void testConfirmationMessage() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        
        Test.startTest();
        MessageGenerator.generateMessage(account.Id, 'CONFIRMATION');
        Test.stopTest();

        List<Switching_Message__c> messages = [
            SELECT Id, Account__c, Type__c, Status__c, Email__c
            FROM Switching_Message__c
            WHERE Account__c = :account.Id
        ];
        
        System.assertEquals(1, messages.size(), 'Should have created one message');
        System.assertEquals('CONFIRMATION', messages[0].Type__c, 'Message type should match');
        System.assertEquals('Pending', messages[0].Status__c, 'Status should be Pending');
        System.assertEquals('test@example.com', messages[0].Email__c, 'Email should match');
    }

    @isTest
    static void testPhoneFallback() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        account.Email__c = null;
        update account;
        
        Test.startTest();
        try {
            MessageGenerator.generateMessage(account.Id, 'WELCOME');
            System.assert(false, 'Should have thrown an exception');
        } catch (MessageGenerator.MessageGeneratorException e) {
            System.assertEquals('Account email is required', e.getMessage(), 'Should throw correct error message');
        }
        Test.stopTest();
    }

    @isTest
    static void testInvalidMessageType() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        
        Test.startTest();
        try {
            MessageGenerator.generateMessage(account.Id, 'INVALID_TYPE');
            System.assert(false, 'Should throw an exception for invalid message type');
        } catch (MessageGenerator.MessageGeneratorException e) {
            System.assertEquals('Account email is required', e.getMessage(), 'Should throw correct error message');
        }
        Test.stopTest();
    }

    @isTest
    static void testGenerateMessage() {
        Account testAccount = new Account(
            Name = 'Test Account',
            Email__c = 'test@example.com'
        );
        insert testAccount;
        
        Test.startTest();
        MessageGenerator.generateMessage(testAccount.Id, 'Test Message');
        Test.stopTest();
        
        List<Switching_Message__c> messages = [
            SELECT Id, Account__c, Type__c, Status__c, Email__c
            FROM Switching_Message__c
            WHERE Account__c = :testAccount.Id
        ];
        
        System.assertEquals(1, messages.size(), 'Should have created one message');
        System.assertEquals('Test Message', messages[0].Type__c, 'Message type should match');
        System.assertEquals('Pending', messages[0].Status__c, 'Status should be Pending');
        System.assertEquals('test@example.com', messages[0].Email__c, 'Email should match');
    }
    
    @isTest
    static void testGenerateMessageWithAdditionalInfo() {
        Account testAccount = new Account(
            Name = 'Test Account',
            Email__c = 'test@example.com'
        );
        insert testAccount;
        
        Test.startTest();
        MessageGenerator.generateMessage(testAccount.Id, 'Test Message', 'Additional Info');
        Test.stopTest();
        
        List<Switching_Message__c> messages = [
            SELECT Id, Account__c, Type__c, Status__c, Email__c, Additional_Info__c
            FROM Switching_Message__c
            WHERE Account__c = :testAccount.Id
        ];
        
        System.assertEquals(1, messages.size(), 'Should have created one message');
        System.assertEquals('Test Message', messages[0].Type__c, 'Message type should match');
        System.assertEquals('Pending', messages[0].Status__c, 'Status should be Pending');
        System.assertEquals('test@example.com', messages[0].Email__c, 'Email should match');
        System.assertEquals('Additional Info', messages[0].Additional_Info__c, 'Additional info should match');
    }
    
    @isTest
    static void testGenerateMessageWithoutEmail() {
        Account testAccount = new Account(
            Name = 'Test Account'
        );
        insert testAccount;
        
        Test.startTest();
        try {
            MessageGenerator.generateMessage(testAccount.Id, 'Test Message');
            System.assert(false, 'Should have thrown an exception');
        } catch (MessageGenerator.MessageGeneratorException e) {
            System.assertEquals('Account email is required', e.getMessage(), 'Should throw correct error message');
        }
        Test.stopTest();
    }
} 