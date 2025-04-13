public class XMLTemplateManager {
    private static final String TEMPLATE_VARIABLE_PATTERN = '\\{\\{([^}]+)\\}\\}';
    
    public static String getTemplate(String processType, String distributor) {
        XML_Template__c template = [
            SELECT Id, Template_Body__c, Version__c
            FROM XML_Template__c
            WHERE Process_Type__c = :processType
            AND Distributor__c = :distributor
            AND Active__c = true
            ORDER BY Version__c DESC
            LIMIT 1
        ];
        
        return template.Template_Body__c;
    }
    
    public static String fillTemplate(String template, Map<String, Object> values) {
        if (template == null || values == null) {
            return null;
        }
        
        String filledTemplate = template;
        Pattern pattern = Pattern.compile(TEMPLATE_VARIABLE_PATTERN);
        Matcher matcher = pattern.matcher(template);
        
        while (matcher.find()) {
            String variable = matcher.group(1);
            Object value = values.get(variable);
            
            if (value != null) {
                String stringValue = String.valueOf(value);
                filledTemplate = filledTemplate.replace('{{' + variable + '}}', stringValue);
            }
        }
        
        return filledTemplate;
    }
    
    public static String generateXML(String processType, String distributor, Map<String, Object> values) {
        String template = getTemplate(processType, distributor);
        return fillTemplate(template, values);
    }
    
    public static String generateXML(Switching_Message__c message) {
        String processType = message.Process_Type__c;
        String distributor = message.Distributor__c;
        
        XML_Template__c template = [
            SELECT Id, Template_Body__c 
            FROM XML_Template__c 
            WHERE Process_Type__c = :processType 
            AND Distributor__c = :distributor 
            AND Active__c = true 
            LIMIT 1
        ];
        
        if (template == null) {
            throw new XMLTemplateException('No active template found for process type: ' + processType + ' and distributor: ' + distributor);
        }
        
        String xmlTemplate = template.Template_Body__c;
        
        // Replace placeholders with actual values
        Map<String, String> fieldValues = new Map<String, String>();
        for (String field : message.getPopulatedFieldsAsMap().keySet()) {
            fieldValues.put('{!' + field + '}', String.valueOf(message.get(field)));
        }
        
        for (String placeholder : fieldValues.keySet()) {
            xmlTemplate = xmlTemplate.replace(placeholder, fieldValues.get(placeholder));
        }
        
        return xmlTemplate;
    }
    
    public class XMLTemplateException extends Exception {}
}