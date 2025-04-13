public with sharing class Switching_Configuration_Selector {
    public static List<Switching_Configuration__c> getConfigurationsByCountryAndProcess(String country, String processType) {
        return [SELECT Id, Country__c, Process_Type__c, Template__c, Integration_Class__c, Active__c
                FROM Switching_Configuration__c
                WHERE Country__c = :country
                AND Process_Type__c = :processType
                AND Active__c = true];
    }
} 