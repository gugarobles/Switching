public with sharing class MessageGenerator {
    public static void generateMessage(Id accountId, String messageType) {
        Account acc = [SELECT Id, Name, Email__c FROM Account WHERE Id = :accountId];
        
        if (acc.Email__c == null) {
            throw new MessageGeneratorException('Account email is required');
        }
        
        Switching_Message__c message = new Switching_Message__c(
            Account__c = accountId,
            Type__c = messageType,
            Status__c = 'Pending',
            Email__c = acc.Email__c
        );
        
        insert message;
    }
    
    public static void generateMessage(Id accountId, String messageType, String additionalInfo) {
        Account acc = [SELECT Id, Name, Email__c FROM Account WHERE Id = :accountId];
        
        if (acc.Email__c == null) {
            throw new MessageGeneratorException('Account email is required');
        }
        
        Switching_Message__c message = new Switching_Message__c(
            Account__c = accountId,
            Type__c = messageType,
            Status__c = 'Pending',
            Email__c = acc.Email__c,
            Additional_Info__c = additionalInfo
        );
        
        insert message;
    }
    
    public static String generateSupplierChangeMessage(Id serviceId) {
        Service__c service = [SELECT Id, CUPS__c, New_Supplier__c, Effective_Date__c 
                            FROM Service__c 
                            WHERE Id = :serviceId];
        
        return 'Supplier Change Request - CUPS: ' + service.CUPS__c + 
               ', New Supplier: ' + service.New_Supplier__c + 
               ', Effective Date: ' + service.Effective_Date__c;
    }
    
    public static String generateSupplierAndHolderChangeMessage(Id serviceId) {
        Service__c service = [SELECT Id, CUPS__c, New_Supplier__c, Effective_Date__c, 
                            New_Holder_Name__c, New_Holder_NIF__c
                            FROM Service__c 
                            WHERE Id = :serviceId];
        
        return 'Supplier and Holder Change Request - CUPS: ' + service.CUPS__c + 
               ', New Supplier: ' + service.New_Supplier__c + 
               ', New Holder: ' + service.New_Holder_Name__c + 
               ', NIF: ' + service.New_Holder_NIF__c + 
               ', Effective Date: ' + service.Effective_Date__c;
    }
    
    public static String generateHolderChangeMessage(Id serviceId) {
        Service__c service = [SELECT Id, CUPS__c, New_Holder_Name__c, New_Holder_NIF__c
                            FROM Service__c 
                            WHERE Id = :serviceId];
        
        return 'Holder Change Request - CUPS: ' + service.CUPS__c + 
               ', New Holder: ' + service.New_Holder_Name__c + 
               ', NIF: ' + service.New_Holder_NIF__c;
    }
    
    public static String generateAltaElectricidadMessage(String cups, String newSupplier, Date effectiveDate, 
                                                       String holderName, String holderNIF, String template) {
        // Reemplazar variables en la plantilla
        String message = template.replace('{CUPS}', cups)
                               .replace('{NEW_SUPPLIER}', newSupplier)
                               .replace('{EFFECTIVE_DATE}', String.valueOf(effectiveDate))
                               .replace('{HOLDER_NAME}', holderName)
                               .replace('{HOLDER_NIF}', holderNIF);
        return message;
    }
    
    public static String generateBajaElectricidadMessage(String cups, String newSupplier, Date effectiveDate, 
                                                       String template) {
        // Reemplazar variables en la plantilla
        String message = template.replace('{CUPS}', cups)
                               .replace('{NEW_SUPPLIER}', newSupplier)
                               .replace('{EFFECTIVE_DATE}', String.valueOf(effectiveDate));
        return message;
    }
    
    public static String generateCambioComercializadoraElectricidadMessage(String cups, String newSupplier, 
                                                                         Date effectiveDate, String template) {
        // Reemplazar variables en la plantilla
        String message = template.replace('{CUPS}', cups)
                               .replace('{NEW_SUPPLIER}', newSupplier)
                               .replace('{EFFECTIVE_DATE}', String.valueOf(effectiveDate));
        return message;
    }
    
    public static String generateCambioTitularElectricidadMessage(String cups, String holderName, String holderNIF, 
                                                                Date effectiveDate, String template) {
        // Reemplazar variables en la plantilla
        String message = template.replace('{CUPS}', cups)
                               .replace('{HOLDER_NAME}', holderName)
                               .replace('{HOLDER_NIF}', holderNIF)
                               .replace('{EFFECTIVE_DATE}', String.valueOf(effectiveDate));
        return message;
    }
    
    public static String generateCambioComercializadoraTitularElectricidadMessage(String cups, String newSupplier, 
                                                                                String holderName, String holderNIF, 
                                                                                Date effectiveDate, String template) {
        // Reemplazar variables en la plantilla
        String message = template.replace('{CUPS}', cups)
                               .replace('{NEW_SUPPLIER}', newSupplier)
                               .replace('{HOLDER_NAME}', holderName)
                               .replace('{HOLDER_NIF}', holderNIF)
                               .replace('{EFFECTIVE_DATE}', String.valueOf(effectiveDate));
        return message;
    }
    
    // Métodos existentes para gas
    public static String generateAltaGasMessage(String cups, String newSupplier, Date effectiveDate, 
                                              String holderName, String holderNIF, String template) {
        // Reemplazar variables en la plantilla
        String message = template.replace('{CUPS}', cups)
                               .replace('{NEW_SUPPLIER}', newSupplier)
                               .replace('{EFFECTIVE_DATE}', String.valueOf(effectiveDate))
                               .replace('{HOLDER_NAME}', holderName)
                               .replace('{HOLDER_NIF}', holderNIF);
        return message;
    }
    
    public static String generateBajaGasMessage(String cups, String newSupplier, Date effectiveDate, String template) {
        // Reemplazar variables en la plantilla
        String message = template.replace('{CUPS}', cups)
                               .replace('{NEW_SUPPLIER}', newSupplier)
                               .replace('{EFFECTIVE_DATE}', String.valueOf(effectiveDate));
        return message;
    }
    
    public static String generateCambioComercializadoraGasMessage(String cups, String newSupplier, 
                                                                Date effectiveDate, String template) {
        // Reemplazar variables en la plantilla
        String message = template.replace('{CUPS}', cups)
                               .replace('{NEW_SUPPLIER}', newSupplier)
                               .replace('{EFFECTIVE_DATE}', String.valueOf(effectiveDate));
        return message;
    }
    
    public static String generateCambioTitularGasMessage(String cups, String holderName, String holderNIF, 
                                                       Date effectiveDate, String template) {
        // Reemplazar variables en la plantilla
        String message = template.replace('{CUPS}', cups)
                               .replace('{HOLDER_NAME}', holderName)
                               .replace('{HOLDER_NIF}', holderNIF)
                               .replace('{EFFECTIVE_DATE}', String.valueOf(effectiveDate));
        return message;
    }
    
    public static String generateCambioComercializadoraTitularGasMessage(String cups, String newSupplier, 
                                                                       String holderName, String holderNIF, 
                                                                       Date effectiveDate, String template) {
        // Reemplazar variables en la plantilla
        String message = template.replace('{CUPS}', cups)
                               .replace('{NEW_SUPPLIER}', newSupplier)
                               .replace('{HOLDER_NAME}', holderName)
                               .replace('{HOLDER_NIF}', holderNIF)
                               .replace('{EFFECTIVE_DATE}', String.valueOf(effectiveDate));
        return message;
    }
    
    public class MessageGeneratorException extends Exception {}
} 